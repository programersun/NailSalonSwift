<?php
/**
 * 图集（相册）相关api
 * 2.0新版api接口文件 2015-3-25
 * @author wangcy
 */
class Album2Action extends CommonAction{
	
	private $model_album;
	private $model_album_image;
	private $model_user;
	public function __construct(){
		parent::__construct();
		$this->model_album		= D("Album");
		$this->model_album_image= D("AlbumImage");
	}
	
	/**
	 * 最新图集<br/>
	 * 2.0追加接口  2015-3-25
	 * @author wangcy  
	 */
	public function album_last(){
		$order	= 'add_time desc';	
		$where	= "is_warn=0";
		$count	= $this->model_album->where($where)->count();
		//每页数据的条数
		$percount=15;
		$this->over_page($count, $percount);
		import("@.ORG.Page");
		$page	= new Page($count,$percount);
		$list	= $this->model_album->field('album_id,user_id,agree_count,description,add_time')
									->where($where)->order($order)
									->limit($page->firstRow,$page->listRows)->select();
		$newList= array();
		$model_user=D("User");
		foreach ($list as $item){
			$item['image']=$this->model_album_image
								->field("cut_path,cut_width,cut_height")
								->where("album_id={$item['album_id']} and is_first=1")->find();
			$item['user'] =$model_user->field("nick_name,role,head_image")->where("user_id={$item['user_id']}")->find();
			array_push($newList, $item);
		}
		$data_count=count($newList);
		returnMsg(1000,$newList);
	}
	
	
	/**
	 * api:根据编号获取图集的详细信息<br/>
	 * 2.0接口  2015-3-25
	 * 方式：post
	 * @param  int  album_id  图集编号
	 * @param  int  user_id	  访问者编号
	 * @author wangcy
	 */
	public function album_detail(){
		$album_id	= I('post.album_id');	//图集编号
		$user_id	= I('post.user_id');	//访问用户的用户编号
		$album		= $this	->model_album
							->field("album_id,user_id,price,tag,description,img_count,agree_count,collect_count,add_time")
							->where("album_id=$album_id and is_warn=0")->find();
		if(!$album) returnMsg(3015);		//图集不存在
		//判断访问用户是否对该图集进行过点赞、收藏操作
		$model_collect	= D("AlbumCollect");
		$model_agree	= D("AlbumAgree");
		$model_attention= D("UserAttention");
		if(!empty($user_id)){
			$is_collect =$model_collect->where("album_id=$album_id and user_id=$user_id")->find();
			$is_agree	=$model_agree  ->where("album_id=$album_id and user_id=$user_id")->find();
			//是否关注用户
			$is_atten	=$model_attention->where("user_id=$user_id and attention_user_id=".$album['user_id'])->find();
// 			$is_attention=$model_user->
		}
		$album['is_collect']=$is_collect? 1 : 0;
		$album['is_agree']	=$is_agree	? 1 : 0;
		$album['is_atten']	=$is_atten	? 1 : 0;
		//图集拥有用户信息
		$model_user = D("User");
		$album['user']=$model_user	->field("user_id,nick_name,head_image,role,attention,by_attention,score,add_time")
									->where("user_id={$album['user_id']}")->find();
		if(!$album['user']) returnMsg(2024);//图集的用户不存在
		$album['user']['album_count']=$this->model_album->where("user_id={$album['user_id']}")->count();
		
		//获取图集中的所有图片
		$album['images']	=$this->model_album_image->where("album_id=$album_id")->select();
		returnMsg(1000,$album);
	}
	
	/**
	 * api:添加图集评论
	 * 2.0接口  2015-3-25
	 * @param int 	 album_id  	图集编号
	 * @param int 	 user_id	评论人编号
	 * @param string content	评论内容
	 * @author wangcy
	 */
	public function comment_add(){
		//post参数
		$album_id	= I("post.album_id",0,"intval");
		$user_id	= I("post.user_id",0,"intval");
		$content	= I("post.content");
		//参数丢失
		if(empty($album_id)||empty($user_id)||empty($content)) returnMsg(1004);
		$data['album_id']	= &$album_id;
		$data['user_id']	= &$user_id;
		$data['content']	= &$content;
		$data['add_time']	= time();
		
		$model	= D("AlbumComment");
		$result	= $model->add($data);
		unset($data);
		if($result){
			returnMsg(1000);
		}else{
			returnMsg(1001);
		}
		
	}
	
	/**
	 * api:图集评论列表
	 * 2.0接口  2015-3-25
	 * @param int album_id 图集编号
	 */
	public function comment_list(){
		$prefix			= C("DB_PREFIX");
		$model_comment	= D("AlbumComment");
		$album_id		= I("post.album_id",0,"inval");
		$percount		= 15;								//每页数据的条数
		$where			= "album_id=$album_id";
		$count			= $model_comment->where($where)->count();
		$this->over_page($count, $percount);
		import("@.ORG.Page");
		$page			= new Page($count,$percount);
		$list			= $model_comment->alias("c")
										->field()
										->join($prefix."user u on c.user_id=u.user_id")
										->where($where)
										->order("add_time desc")
										->limit($page->firstRow,$page->listRows)->select();
		if($list){
			returnMsg(1000,$list);
		}elseif ($list === null){
			returnMsg(1003);
		}else{
			returnMsg(1002);
		}
	}
	
}