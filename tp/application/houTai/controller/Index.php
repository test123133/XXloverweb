<?php
namespace app\houTai\controller;
use think\Controller;
use app\houTai\controller\Limit;
use app\houTai\model\Employe;
use think\Db;
class Index extends Controller
{
    public function index()
    {
        //判断当前用户是否拥有访问权限
        $limit=new Limit();
        $power=$limit->index();
        if($power){
            $menuList = Db::table('menu')
                ->alias('a')
                ->join('rights b','a.right_id = b.right_id')
                ->select();
            $this->assign('menuList',$menuList);
           return $this->fetch('');
        }else{
            echo "您没有权限访问该页面";
        }
    }
    public function employe(){
        //判断当前用户是否拥有访问权限
        $limit=new Limit();
        $power=$limit->index();
        if($power){
            $employeList=Db::table('emp_main')
                ->alias('a')
                ->join('picture b','a.emp_head_img_id = b.picture_id')
                ->join('role_con_emp c','a.emp_id = c.emp_id')
                ->join('role d','d.role_id = c.emp_id')
                ->select();

            $this->assign('employeList',$employeList);
           // echo '<pre>';
           // var_dump($employeList);
            return $this->fetch('');
        }else{
            echo "您没有权限访问该页面";
        }

    }
}
