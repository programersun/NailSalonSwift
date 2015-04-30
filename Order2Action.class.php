<?php
/**
 * 订单相关2.0追加
 * @author duostec
 */
class Order2Action extends CommonAction{
	
	private $model_order;
	private $model_user;
	public function __construct(){
		parent::__construct();
		$this->model_order=D("Order");
	}
	
	/**
	 * api:用户订单列表
	 * 2.0修改 2015-4-1
	 */
	public function order_list(){
		$user_id = I("post.user_id",0,"intval");
		$role	 = I("role",0,"intval");			//用户角色，1：普通用户，2：美甲师
		if(empty($user_id))		returnMsg(2021);	//用户编号丢失
		if(1!=$role&&2!=$role)	returnMsg(2014);	//用户角色丢失
		$prefix	 = C("DB_PREFIX");					
		switch ($role){
			case 1: 		//普通用户
				//添加   field:o.pre_status 2015-4-1
				//    where:and isDel=0
				$field = "o.user_id as uid,u.nick_name,u.head_image,o.pre_status,o.order_id,o.real_name,o.detail_addr,o.order_time add_time,o.pre_status,o.order_status";
				$where = "o.custom_id=$user_id and o.order_status<>8 and isDel=0";
				$join  = $prefix."user u on u.user_id=o.user_id";
				break;
			case 2:			//美甲师
				//添加  field:o.pre_status 2015-4-1
				//    where:and isDel=0
				$field = "o.custom_id as uid,u.nick_name,u.head_image,o.pre_status,o.order_id,o.detail_addr,o.order_time add_time,o.pre_status,o.order_status";
				$where = "o.user_id=$user_id and o.order_status<>2 and o.order_status<>9 and isDel=0";
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
	
	
	/**
	 * api:修改订单状态
	 * 2.0修改 2015-4-1
	 */
	public function change_order_status(){
		$status = I("post.status",1,"intval");
		$role	= I("post.role",0,"intval");
		$this->isExist($_POST['user_id']);
		
		//修改 change_order_status改为change_order_status2
		//2015-4-1
		$result=$this->model_order
			->change_order_status2($status,$_POST['order_id'],$role,$_POST['user_id']);
		returnMsg($result);
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