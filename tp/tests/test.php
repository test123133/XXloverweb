<?php
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


