<?php
/**
 * 用户相关api
 * @author duostec
 */
class UserAction extends CommonAction{
	
	private $data;
	private $user;
	private $model_user;
	private $md5_str="duostec#meijia";
	public function __construct(){
		parent::__construct();
		$this->model_user=D("User");
	}
	
	/**
	 * api:登陆
	 */
	public function login(){
		$user_name	=	I("post.user_name");
		$password 	=	I("post.password");
		$password	=	md5($this->md5_str.$password);
		$where		=	"user_name='$user_name' and password='$password'";
		$this->user=$this->model_user->field("user_id,nick_name,role")->where($where)->find();
		if(false===$this->user){
			returnMsg(1002);
		}elseif (''===$this->user||null===$this->user){
			returnMsg(2011);
		}else{
			returnMsg(1000,$this->user);
		}
	}
	
	/**
	 * api:注册 
	 */
	public function register(){
		$this->data['user_name']	= I('post.user_name');
		$password					= I('post.password');
		$this->data['password']		= md5($this->md5_str.$password);
		$this->data['role']			= I('post.role');
		$this->data['add_time']		= time();
		$hasUserName	= $this->model_user->field("user_id")->where("user_name='{$this->data['user_name']}'")->find();
		if($hasUserName){
			returnMsg(2025);
		}
		if(2==$this->data['role']){
			$result=$this->model_user->add($this->data);
			$user_id = $this->model_user->getLastInsID();
			if($result){
				$tech_result=$this->register_tech($result);
// 				if(!$tech_result){
// 					$this->model_user->where("user_id=$result")->delete();
// 					returnMsg(2012);
// 				}
			}
		}elseif(1==$this->data['role']){
			$this->data['is_pass']	= 1;
			$result=$this->model_user->add($this->data);
			$user_id = $this->model_user->getLastInsID();
		}else{
			returnMsg(1007);
		}
		
		if(!$result){
			returnMsg(2012);
		}else{
			//环信添加用户
			import("@.ORG.Easemob");
			$option_easemob = C("easemob");
			$easemob = new Easemob($option_easemob);
			$easemob_reg = $easemob->registerToken($user_id, '12345678');
			if(!$easemob_reg){
				returnMsg(2012);
			}
			Log::write("环信注册用户返回信息：".json_encode($easemob_reg),'INFO');
			returnMsg(1000,$result);
		}
	}
	
	/**
	 * api:第三方登陆
	 */
	public function third_login(){
		//第三方登录名称
		$this->data['third_name']	= I("post.third_name");
		//第三方登录用户编号
		$this->data['uid']			= I("post.uid");
		$this->data['role']			= I('post.role');
		$this->data['nick_name']	= I("post.nick_name");
		$this->data['head_image']	= I("post.head_image");
		$this->data['sex']			= I("post.sex");
		$this->data['add_time']		= time();
		$hasUser = $this->model_user->field("user_id,nick_name,role")->where("uid='{$this->data['uid']}' and third_name = '{$this->data['third_name']}'")->find();
		if($hasUser){
			returnMsg(2040,$hasUser);
		}
		if(2==$this->data['role']){
			$result=$this->model_user->add($this->data);
			$user_id = $this->model_user->getLastInsID();
			
		}elseif(1==$this->data['role']){
			$this->data['is_pass']	= 1;
			$result=$this->model_user->add($this->data);
			$user_id = $this->model_user->getLastInsID();
		}else{
			returnMsg(1007);
		}
	
		if(!$result){
			returnMsg(2012);
		}else{
			//环信添加用户
			import("@.ORG.Easemob");
			$option_easemob = C("easemob");
			$easemob = new Easemob($option_easemob);
			$easemob_reg = $easemob->registerToken($user_id, '12345678');
			if(!$easemob_reg){
				returnMsg(2012);
			}
			$user = $this->model_user->field("user_id,nick_name,role")->where("user_id= $user_id")->find();
			returnMsg(1000,$user);
		}
	}
	
	/**
	 * api：绑定用户名（即电话号）
	 */
	public function lock_user_name(){
		$user_id 	= I("post.user_id");
		$user_name	= I("post.user_name");
		$password	= I("post.password");		//默认密码
		$hasUserName = $this->model_user->field("user_id")->where("user_name = '$user_name'")->find();
		$user	 	 = $this->model_user->field("user_id,user_name,password")
										->where("user_id=$user_id")->find();
		if($hasUserName){
			returnMsg(2026);	//该电话号已经绑定
		}
		
		if(!$user){
			returnMsg(2024);	//用户不存在
		}
		$user['user_name']	= $user_name;
		$user['password']	= md5($this->md5_str.$password);
		$result = $this->model_user->save($user);
		if($result){
			returnMsg(1000);
		}else{
			returnMsg(2042);
		}
	}
	
	/**
	 * api:更改密码
	 */
	public function rePass(){
		$user_id = I("post.user_id");
		$pass	 = I("post.pass");
		$rePass	 = I("post.rePass");
		//参数验证
		if(empty($user_id)||empty($pass)||empty($rePass)){
			returnMsg(1004);
		}
		try {
			$pass	= md5($this->md5_str.$pass);
			$rePass = md5($this->md5_str.$rePass);
			$hasUser = $this->model_user->where("user_id=$user_id and password='$pass'")->find();
			if($hasUser){
				$result = $this->model_user->where("user_id=$user_id")->setField("password", $rePass);
				if($result){
					returnMsg(1000);
				}else{
					returnMsg(1001);
				}
			}else{
				returnMsg(2011);
			}
		} catch (Exception $e) {
			Log::record("修改密码：".$e->getMessage());
			returnMsg(1001);
		}
	}
	/**
	 * 填写美甲师验证信息
	 * @param int $user_id
	 * @return Ambigous <mixed, boolean, unknown, string>
	 */
	private function register_tech($user_id){
		
		$data['user_id']	= $user_id;
		$data['ident_code']	= I('post.ident_code');
		$data['real_name']	= I('post.real_name');
		if(empty($data['ident_code'])||empty($_FILES['Filedata'])){
			return true;
		}
		$path				= "./Upload/user/identity/";
		$data['ident_pic']	= $this->uploadImg($path);
		if(!file_exists($data['ident_pic'])) {
// 			$this->model_user->where("user_id=$user_id")->delete();
			returnMsg(1005);
		}
		
		$model_user_tech =D("UserTech");
		$result = $model_user_tech->add($data);
		return $result;
	}
	
	//api：美甲师上传资料，进行审核
	public function verify_tech(){
		$data['user_id']	= $_POST['user_id'];
		$data['ident_code']	= $_POST['ident_code'];
		$data['real_name']	= $_POST['real_name'];
		if(empty($data['ident_code'])||empty($_FILES['Filedata'])||empty($data['real_name'])){
			return 1008;
		}
		$path				= "./Upload/user/identity/";
		$data['ident_pic']	= $this->uploadImg($path);
		if(!file_exists($data['ident_pic'])) {
			returnMsg(1005);
		}
		$model_user_tech =D("UserTech");
		$user		= $this->model_user->field("role,is_pass")->where("user_id=".$data['user_id'])->find();
		//验证该美甲师是否存在，并且已经审核过资料
		if(!$user||2!=$user['role']||1==$user['is_pass']) returnMsg(1009);
		$check_user = $model_user_tech->where("user_id=".$data['user_id'])->find();
		if($check_user){
			$result = $model_user_tech->save($data);
		}else{
			$result = $model_user_tech->add($data);
		}
		
		if($result){
			returnMsg(1000);
		}else{
			returnMsg(1001);
		}
		
	}
	
	/**
	 * api:获取用户详细信息
	 */
	public function userInfo(){
		$user_id	= I('post.user_id');
		if(empty($user_id)) returnMsg(2020);
		$this->data = $this ->model_user
							->field('nick_name,user_name,role,real_name,sex,tel,address,head_image,attention,by_attention,score,longitude,latitude')
							->where("user_id=$user_id")->find();
		if(false===$this->data){
			returnMsg(1002);
		}elseif (''===$this->data||null===$this->data){
			returnMsg(2021);
		}else{
			returnMsg(1000,$this->data);
		}
	}
	
	/**
	 * api:获取其他一个用户的详细信息
	 */
	public function another_user_info(){
		$user_id	= I('post.user_id');
		$my_user_id = I('post.my_user_id');		//访问者用户ID
		if(empty($user_id)) returnMsg(2020);
		$this->data = $this ->model_user
							->field('nick_name,role,real_name,sex,tel,address,album_count,order_count,order_count2,head_image,attention,by_attention,score,longitude,latitude')
							->where("user_id=$user_id")->find();
		if(false===$this->data){
			returnMsg(1002);
		}elseif (''===$this->data||null===$this->data){
			returnMsg(2021);
		}else{
			if(!empty($my_user_id)){
				$model_atten = D("UserAttention");
				$is_attn = $model_atten->where("user_id=$my_user_id and attention_user_id = $user_id")->find();
				
			}
			$this->data['is_attention'] = $is_attn?1:0;
			returnMsg(1000,$this->data);
		}
	}
	
	/**
	 * api:修改用户头像  
	 */
	public function modifyHeadImage(){
		$data['user_id']	= I("post.user_id");
		if(empty($data['user_id'])) returnMsg(2021);
		$old_image			= $this->model_user->where("user_id=".$data['user_id'])->getField("head_image");
		$path	= './Upload/user/';
		$data['head_image']	= $this->uploadImg($path);
		if(!file_exists($data['head_image'])) returnMsg(1005);
		$result	= $this->model_user->save($data);
		if($result){
			if(!empty($old_image)) unlink($old_image);
			returnMsg(1000,$data['head_image']);
		}else{
			unlink($data['head_image']);
			returnMsg(1001);
		}
	}
	
	/**
	 * api:修改用户信息
	 */
	public function modifyUserInfo(){
		$data['user_id']	= I("post.user_id");
		$data['real_name']	= I("post.real_name");
		$data['tel']		= I("post.tel");
		$data['address']	= I("post.address");
		$sex				= I("post.sex");
		$data['sex']		= empty($sex)?0:$sex;
		$nick_name			= I("post.nick_name");
		if(!empty($nick_name))	$data['nick_name']=I("post.nick_name");
		if(empty($data['user_id'])) returnMsg(2021);
		$result = $this->model_user->save($data);
		if($result){
			returnMsg(1000);
		}else{
			returnMsg(1001);
		}
	}
	
	/**
	 * api:修改用户位置信息
	 */
	public function changeCoordinate(){
		$data['user_id'] 	= I("post.user_id");
		$data['longitude']	= I("post.longitude");
		$data['latitude']	= I("post.latitude");
		$data['city']		= I("post.city");
		if($this->checkEmpty($data))	returnMsg(1008);	
		$result = $this->model_user->save($data);
		if($result){
			returnMsg(1000);
		}else{
			returnMsg(2023);
		}
	}
	
	/**
	 * api:关注、取消关注
	 */
	public function attention(){
		$ctrl 		=	$_POST['control'];			//操作标志，1：关注，2：取消关注
		$user_id	=	$_POST['user_id'];			//关注用户编号
		$att_user_id=	$_POST['attention_user_id'];//被关注用户编号
		//判断用户是否存在
		$user = $this->isExist($user_id,"user_id,role,nick_name,head_image");
		$this->isExist($att_user_id);
		
		$model_atten=	D("UserAttention");
		switch ($ctrl){
			case 1:
				$data	= array('user_id'=>$user_id,'attention_user_id'=>$att_user_id,'add_time'=>time());
				$result = $model_atten->add($data);
				if($result){
					//用户关注数、被关注数+1
					$this->model_user->where("user_id=$user_id")->setInc("attention",1); 
					$this->model_user->where("user_id=$att_user_id")->setInc("by_attention",1);	
					//极光推送
					try{
						vendor("JPush.PushAction");
						$pushAlias = array($att_user_id);
						$message = array(
								"type"	=> '4000',
								"data"	=> array(	"id"	=>$user_id,
										"role"	=>$user['role'],
										"nick"	=>$user['nick_name'],
										"head"	=>$user['head_image'],
										"send_time"=>time()),
						);
						$Push = new PushAction();
						$Push->push($pushAlias, $message);
					}catch (Exception $e){
						Log::write("推送失败：".$e->getMessage());
					}
					
					returnMsg(1000);	//用户关注成功
				}else{
					returnMsg(2028);	//用户关注失败
				}
				break;
			case 2:
				$where		= "user_id=$user_id and attention_user_id=$att_user_id";
				$hasAtten	= $model_atten->where($where)->find();
				if($hasAtten){
					$result	= $model_atten->where($where)->delete();
					if($result){
						//用户关注数、被关注数-1
						$this->model_user->where("user_id=$user_id")->setDec("attention",1);
						$this->model_user->where("user_id=$att_user_id")->setDec("by_attention",1);
						returnMsg(1000);	//取消关注成功
					}else{
						returnMsg(2034);	//取消关注失败
					}
				}else{
					returnMsg(2030);	//尚未关注
				}
				break;
			default:
				//无效操作
				returnMsg(1009);		
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
		$result= $this->model_user->field($field)->where("user_id=$user_id")->find();
		if($result){
			return $result;
		}else{
			returnMsg(2024);
		}
	}
	/**
	 * common:上传图片（单张）
	 * @param string $path	图片保存文件夹
	 * @return string		图片保存路径（完整）
	 */
	private function uploadImg($path){
		$file	= $_FILES['Filedata'];
		$upload = upload_file($path, $file);
		if(false==$upload['result']){
			returnMsg(1006,$upload['msg']);
		}
		return $path.$upload['images'][0]['savename'];
	}
}