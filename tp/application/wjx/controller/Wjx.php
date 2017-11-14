<?php
namespace app\wjx\controller;

use think\Controller;
use think\Request;
use app\wjx\model\Employe;
use app\wjx\model\Lists;
use think\Db;
use think\Cache;
class Wjx extends Controller
{
      public function index()
    {
       // 获取包含域名的完整URL地址
	   $url=url('wjx/Wjx/login');
	   $this->assign('url',$url);
		//echo $url;
       return $this->fetch('');
    }
	public function login()
	{
		return $this->fetch('');
	}
	public function QQlogin(){
        $user_exist=Request::instance()->has('user','post');
        if($user_exist){
            //input('请求类型.变量名'，'默认值'，'过滤器') 过滤器=> FILTER_VALIDATE_INT (INT代表整形，或者也可以用其他类型)
            $username=input('post.user');
            $password=input('post.psd');
           // dump($username); //dump tp自带打印函数;
            //$ueserInfo=model('employe')->where($where)->find();
            //dump($ueserInfo);
            //查询
            //$res=Db::query("select * from t_employe where emId=?",[1]);
            //插入
           // $res=Db::execute("insert into t_employe values(?,?,?,?,?,?)",[7,'kaven','12345678',8,'未锁','否']);
            //find()值查询一条，select()可以查询所有的结果;
           // $res=Db::table('t_employe')->where(['emName' => 'root'])->select();
            //value返回一条结果,column返回所有的结果；
            //value('','')如果是一维数组他们是一键值对关系存在！！！
            //$res=Db::table('t_employe')->value('emName','emPsd');
            //在配置文件中中设置了表前缀不需要写t_,此处为省略写法；
            //,[],false添加可以不需要每次去使用去调用数据库，因为前面都是单利模式；
            //$res=Db('employe',[],false)->find();
            //$db=Db::name('employe');
            //where 和 whereOr 是且和或的关系;field('name')和*对应，得到的结果只为name；
            //order('id DESC')降序排序；limit（3,5）从第三天开始选到第五条；
            //插入数据库 insert(或者用insertGetId获取自增id);page(2,5)第二页开始的五条；grpup('how')分组排序；
            //$res=$db->insert(['' => '']);
            //更新数据库update
            //$res=$db->where(['emId' => 7])->update(['emPsd' => '123456']);
            //删除数据delete(n),n值为主键值；
            //$res=$db->where(['emId' => 7])->delete();
            //$res=$db->where(['emId' => 6])->find();
            //$res=Employe::get(1);
           // $res=$res->toArray();//将对象转为数组
             $where=[
                'emName' => $username,
                'emPsd'  =>md5($password)
                ];
            $res=Employe::where($where)->find();
            if($res){
                $this->success('登录成功','wjx/wjx/personal',1);
            }else{
                $this->error("账号或密码错误","wjx/wjx/login",1);
            }



        }
	}
    public function personal()
    {
        //$res=User::where([])->find();  $res=$res->toArray();//将对象转为数组
        //$res=User::where([])->value(name)  获取字段名为name的值；
        //数据库中插入数据 create($data,true) true过滤掉没有的字段;插入所有insertALL($data)；或者可以用save方法，$userModel=new User;$userModel->save([key => value])
        //更新数据，User::where('id','>',5)->update([name => value])
        //删除数据 User::destroy([id => value]) 值也可以直接写成 (主键)，或者 Lists::where('id','>',5)->delete();
        //先获取再删除,更新等都类似；$userModel=User::get(1);$userModel->delete();
        //获取数据条数：User::count();或者User::where('id','>',5)->count();
        //获取最大：User::max();或者User::where('id','>',5)->max();
        //获取字段的 和 ：User::sum();或者User::where('id','>',5)->sum();
        //同理 平均值 avg;最小值min；
       /* $data=[];
        for($i=1;$i<50;$i++){
            $data[]=[
                'title' => "问卷星标题{$i}",
                'info'  => "问卷星内容{$i}"
            ];
        }
        $res=Lists::insertALL($data);*/
        /* foreach($wjxList as $value){
           dump($value->toArray());
       }*/
        $search_exist=Request::instance()->has('search','post');
        if($search_exist){
            $search=input('post.search','');
            $wjxList= Cache::get('wjx'.$search);
            if(!$wjxList){
                echo '数据库查询';
                $wjxList=Lists::where('title','like',"%{$search}%")->whereOr('info','like',"%{$search}%")->paginate(3);
                Cache::set('wjx'.$search,$wjxList,3600);
            }
        }else{
            $wjxList=Lists::paginate(3);
        }
        $this->assign('wjxList',$wjxList);
        return $this->fetch('');
    }
    public function publish()
    {
        return $this->fetch('');
    }
    public function local(){
        //Memcache缓存
        $mem=new Memcache();
        $menCon=$mem->connect('127.0.0.1',11211);//Memcache端口号
        //设置Memcache缓存
        $mem->set('name','123');
        //读取缓存
        $name=$mem->get('name');
        var_dump($name);


        //redis缓存,有键值对、哈希、队列、集合
        //键值对
        $redis=new Redis();
        $redisCon=$redis->connect('127.0.0.1',6379);//Memcache端口号
        //设置Memcache缓存
        $redis->set('name','456');
        //读取缓存
        $value=$redis->get('name');
        var_dump($value);


        //哈希
        $redis->hSet("you","age","100");
        $age=$redis->hGet("you","age");
        echo $age;//得到值为100；


    }
}
