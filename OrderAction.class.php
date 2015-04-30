<?php
/**
 * 订单相关
 * @author duostec
 */
class OrderAction extends CommonAction{
	
	private $model_order;
	private $model_user;
	public function __construct(){
		parent::__construct();
		$this->model_order=D("Order");
	}
	
	//api:用户订单列表
	public function order_list(){
		$user_id = I("post.user_id",0,"intval");
		$role	 = I("role",0,"intval");			//用户角色，1：普通用户，2：美甲师
		if(empty($user_id))		returnMsg(2021);	//用户编号丢失
		if(1!=$role&&2!=$role)	returnMsg(2014);	//用户角色丢失
		$prefix	 = C("DB_PREFIX");					
		switch ($role){
			case 1: 		//普通用户
				$field = "o.user_id as uid,o.order_id,o.real_name nick_name,o.detail_addr,o.order_time add_time,o.order_status";
				$where = "o.custom_id=$user_id and o.order_status<>8";
				$join  = $prefix."user u on u.user_id=o.user_id";
				break;
			case 2:			//美甲师
				$field = "o.custom_id as uid,o.order_id,u.nick_name,o.detail_addr,o.order_time add_time,o.order_status";
				$where = "o.user_id=$user_id and o.order_status<>2 and o.order_status<>9";
				$join  = $prefix."user u on u.user_id=o.custom_id";
				break;
			default:
				returnMsg(1001);	//操作失败
		}
		$count = $this->model_order->alias('o')->where($where)->count();
		import("@.ORG.Page");
		$page  = new Page($count,15);
		$this->over_page($count, 15);
		$list  = $this->model_order->alias('o')->join($join)
						->field($field)->where($where)->order("o.order_status,o.order_time desc")
						->limit($page->firstRow,$page->listRows)->select();
		if($list){
			returnMsg(1000,$list);
		}else{
			returnMsg(1002);
		}
	}
	
	//api:添加订单
	public function order_add(){
		$data['user_id']	= I("post.user_id");		//美甲师id
		$data['custom_id']	= I("post.custom_id");		//顾客id
		$data['real_name']	= I("post.real_name");		//顾客姓名
		$data['sex']		= I("post.sex");			//性别
		$data['order_time']	= I("post.order_time",0,'intval');		//预约时间 时间戳
// 		$data['order_addr']	= I("post.order_addr");		//预约地点
		$data['tel']		= I("post.tel");			//顾客电话
		$data['detail_addr']= I("post.detail_addr");	//详细地址
		if($this->checkEmpty($data)) returnMsg(1004);
		//2015-4-3 start
		$data['album_id']	= I("post.album_id",0,'intval');
		$data['album_desc']	= I("post.album_desc");		//图集描述
		//2015-4-3 end
		//检查用户编号是否存在，并检查user_id是否为美甲师
		$this->model_user	= D('User');
		$this->isExist($data['user_id']);
		$this->isExist($data['custom_id']);
		$checkRole	= $this->model_user->checkRole($data['user_id']);
		if($data['user_id']==$data['custom_id'])	returnMsg(4019);
		if(2!=$checkRole){
			returnMsg(4013);		//下单对象必须为美甲师
		}
		$data['add_time']	= time();
		$data['order_id']	= $this->model_order->create_order_id();	//生成订单编号
		$result=$this->model_order->add($data);
		if($result){
			//极光推送
			try{
				vendor("JPush.PushAction");
				$pushAlias = array($data['user_id']);	
				$message = array(
						"type"	=> '4002',
						"data"	=> array(	"id"	=>$data['order_id'],
								"nick"	=>$data['real_name'],
								"order"	=>$data['order_id'],
								"time"	=>$data['order_time'],
								"place"	=>$data['detail_addr'],
								"send_time"=>time()),
				);
				$Push = new PushAction();
				$Push->push($pushAlias, $message);
			}catch (Exception $e){
				Log::write("推送失败：".$e->getMessage());
			}
			returnMsg(1000,$data['order_id']);
		}else{
			returnMsg(4001);
		}
	}
	
	//api:订单详细
	public function order_detail(){
		$model_comment = D("OrderComment");
		$model_image   = D("OrderCommentImage");
		if(!$this->model_user)	$this->model_user = D("User");
		$order_id = I("post.order_id");
		$order = $this->model_order->where("order_id='$order_id'")->find();
		if($order){
			$order['user'] 	 = $this->model_user->field("user_id,tel,head_image,user_name,nick_name,score")
								->where("user_id=".$order['user_id'])->find();
			$order['custom'] = $this->model_user->field("user_id,head_image,role,nick_name,score,score2")
								->where("user_id=".$order['custom_id'])->find();
			if(!empty($order['comm_id'])){
				$order['user']['comment'] = $model_comment->where("comment_id=".$order['comm_id'])->find();
				$image = $model_image->where("comment_id=".$order['comm_id'])->find();
				if($image){
					$order['user']['comment'] =array_merge($order['user']['comment'],$image);
				}
			}
			if(!empty($order['comm_touser_id'])){
				$order['custom']['comment'] = $model_comment->where("comment_id=".$order['comm_touser_id'])->find();
				$image = $model_image->where("comment_id=".$order['comm_touser_id'])->find();
				if($image){
					$order['custom']['comment'] = array_merge($order['custom']['comment'],$image);
				}
			}
			returnMsg(1000,$order);
		}else{
			returnMsg(4005);
		}
	}
	
	//api:添加订单评论
	public function order_comment_add(){
		$role				= I("post.role");			//评论用户的角色，1：普通用户，2：美甲师
		$order_id			= I("post.order_id");       //订单编号
		$data['comment']	= I("post.comment");		//评论
		$data['score']		= I("post.score");			//评分
		if($this->checkEmpty($data)) returnMsg(1004);
		if(empty($role)||empty($order_id)) returnMsg(1004);
		//订单未完成时（交易完成，取消完成），不允许评论
		//根据角色id，确定对应的数据库字段
		if($role==1){
			$role_field="comm_id";
		}elseif ($role==2){
			$role_field="comm_touser_id";
		}else{
			returnMsg(2014);
		}
		$where = "order_id = '$order_id'";
		$order		= $this->model_order->field("order_id,user_id,custom_id,$role_field,order_status")->where($where)->find();
		if(!$order) 				returnMsg(4005);	//订单不存在
		/*订单状态
			1：发出订单
			2：用户取消订单
			3：美甲师拒绝订单
			4：美甲师接受订单
			5：美甲师取消订单
			6：用户取消订单（美甲师接受订单后）
			7：交易完成
			8：用户删除订单（隐藏）
			9：美甲师删除订单（隐藏）*/
		if(5>$order['order_status']) returnMsg(4015);
		if($order[$role_field])	returnMsg(4009);	//订单已经评论
		$data['add_time']	= time();
		$model_comment		= D("OrderComment");
		$add_result	= $model_comment->add($data);
		if(!$add_result)	returnMsg(4007);			//评论添加失败
		$add_id		= $model_comment->getLastInsID();	//评论编号
		if(empty($add_id)) returnMsg(4011);				//评论编号不存在
		$this->add_image($add_id);
		
		$order[$role_field]	= $add_id;
		$result=$this->model_order->save($order);
		if($result){
			//------------修改用户评分  start---------------
			$this->model_user = D("User");
			$user_field = $role==1 ? 'user_id' : 'custom_id';
			$user_id = $order[$user_field];   //用户id
			$user	 = $this->model_user->field("role,score,score2")->where("user_id=$user_id")->find();
			$count   = $this->model_order->where("$user_field=$user_id and $role_field>0")->count();
			if(2==$role&&2==$user['role']){
				$score =($user['score2']*($count-1)+$data['score'])/$count;
				$this->model_user->where("user_id=$user_id")->setField("score2", $score);
			}else{
				$score =($user['score2']*($count-1)+$data['score'])/$count;
				$this->model_user->where("user_id=$user_id")->setField("score",$score);
			}
			//------------修改用户评分 end------------------
			returnMsg(1000);
		}else{
			$model_comment->where("comment_id=$add_id")->delete();
			returnMsg(4007);		//评论添加失败
		}
	}
	
	//api:修改订单状态
	public function change_order_status(){
		$status = I("post.status",1,"intval");
		$role	= I("post.role",0,"intval");
		$this->isExist($_POST['user_id']);
		$result=$this->model_order
			->change_order_status($status,$_POST['order_id'],$role,$_POST['user_id']);
		returnMsg($result);
	}
	
	/**
	 * 添加评论的图片
	 * @param int $comment_id  评论编号
	 */
	private function add_image($comment_id){
		$upload_images	= $_FILES['Filedata'];		 //获取上传图片
		$is_empty = isset($upload_images[0]['name'])?$upload_images[0]['name']:$upload_images['name'];
		if(!empty($is_empty)){
			$model_comment_image=D("OrderCommentImage");
			$date	=	date("Ymd");						//日期
			$path	=	"./Upload/comment/$date/";			//路径
			$images	=	upload_file($path, $upload_images);
			if(false==$images['result']) returnMsg(1006);
			$count = count($images['images']);
			if(1<=$count){
				$add_time = time();
				import("@.ORG.Resizeimage");
				$resize=new Resizeimage();
				$resize->initAttribute($path, 300, 300, 2);
				
				for ($i=0;$i<$count;$i++){
					$resize->setSize(300, 300);
					$cutimg=$resize->resize($images['images'][$i]['savename']);
					if(!$cutimg){
						unlink($path.$images['images'][$i]['savename']);
						continue;
					}
					$img['comment_id']	=	$comment_id;
					$img['image_path']	=	$resize->srcimg;
					$img['height']		=	$resize->height;
					$img['width']		=	$resize->width;
					$img['cut_path']	=	$resize->dstimg;
					$img['cut_height']	=	$resize->resize_height;
					$img['cut_width']	=	$resize->resize_width;
					$img['add_time']	=	$add_time;
					$result=$model_comment_image->add($img);
				}
			}
		}
	}
	
	/**
	 * 判断用户id是否存在<br/>
	 * 如果编号存在，返回用户信息
	 * @param int 		$user_id	用户编号
	 * @param string	$field		返回字段
	 * @return mix
	 */
	public function isExist($user_id,$field=''){
		if(empty($user_id))	returnMsg(2021);
		$field = empty($field)?'user_id':$field;
		if(!$this->model_user) $this->model_user=D("User");
		$result= $this->model_user->field($field)->where("user_id=$user_id")->find();
		if($result){
			return $result;
		}else{
			returnMsg(2024);
		}
	}
}