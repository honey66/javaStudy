package cn.hp.project._02_spark_dmp.utils

import com.typesafe.config.ConfigFactory

/**
  * 配置参数获取的帮助类
  */
object ConfigUtils {
  //加载配置参数
  val conf  = ConfigFactory.load()

  //sparkSession sql shuffle的分区数设置
  val SPARK_SQL_SHUFFLE_PARTITIONS = conf.getString("sparkSession.sql.shuffle.partitions")
  //sparkSession sql小表自动广播的大小限制
  val SPARK_SQL_AUTOBROADCASTJOINTHRESHOLD = conf.getString("sparkSession.sql.autoBroadcastJoinThreshold")
  //设置shuffle数据是否进行压缩
  val SPARK_SHUFFLE_COMPRESS = conf.getString("sparkSession.shuffle.compress")
  //设置shuffle失败时的重试次数
  val SPARK_SHUFFLE_IO_MAXRETRIES = conf.getString("sparkSession.shuffle.io.maxRetries")
  //设置shuffle重试的时间间隔
  val SPARK_SHUFFLE_IO_RETRYWAIT = conf.getString("sparkSession.shuffle.io.retryWait")
  //设置广播数据是否压缩
  val SPARK_BROADCAST_COMPRESS = conf.getString("sparkSession.broadcast.compress")
  //设置spark的序列化方式
  val SPARK_SERIALIZER =  conf.getString("sparkSession.serializer")
  //设置执行与存储的内存比例
  val SPARK_MEMORY_FRACTION = conf.getString("sparkSession.memory.fraction")
  //设置存储的内存比例
  val SPARK_MEMORY_STORAGEFRACTION = conf.getString("sparkSession.memory.storageFraction")
  //设置sparkcore的shuffle分区数
  val SPARK_DEFAULT_PARALLELISM = conf.getString("sparkSession.default.parallelism")
  //设置数据本地化的等待时间
  val SPARK_LOCALITY_WAIT = conf.getString("sparkSession.locality.wait")
  //是否启动推测机制
  val SPARK_SPECULATION = conf.getString("sparkSession.speculation.flag")
  //推测机制的启动时机
  val SPARK_SPECULATION_MULTIPLIER = conf.getString("sparkSession.speculation.multiplier")

  //APPID_NAME的字典文件
  val APPID_NAME = conf.getString("appID_name")
  //#设置设备的字典文件
  val DEVICEDIC = conf.getString("devicedic")
  //#设置解析经纬度的数据路径
  val GEOLITECITY = conf.getString("GeoLiteCity.dat")
  //#纯真数据库的名称
  val IP_FILE = conf.getString("IP_FILE")
  //#纯真数据库所处的目录
  val INSTALL_DIR = conf.getString("INSTALL_DIR")
  //获取ip解析省份城市的http url
  val PARSE_IP_URL = conf.getString("PARSE_IP_URL")
  //设置kudu集群的master地址
  val MASTER_ADDRESS = conf.getString("master_address")
  //设置商圈库的获取的url
  val BUSINESS_AREA=conf.getString("BUSINESS_AREA_URL")

  /**
    * sparkSession.speculation="true"
    * #设置推测机制的启动时机
    * sparkSession.speculation.multiplier="1.5"
    *
    * class Spark{
    *   private val speculation:Speculation
    * }
    *
    * class Speculation{
    *  private String multiplier;
    *  private String flag
    * }
    *
    * val sparkSession = new Spark
    * sparkSession.speculation.multiplier
    * sparkSession.speculation.flag
    *
    */

}
