package cn.sdrfengmi.flink._03_stream_base.stream.datasource

import org.apache.flink.streaming.api.scala.{DataStream, StreamExecutionEnvironment}

object DataSource_CSV {

  def main(args: Array[String]): Unit = {

    // 1. 流处理环境
    val env = StreamExecutionEnvironment.getExecutionEnvironment
    // 2. 读取HDFS中的CSV文件
    val csvDataStream: DataStream[String] = env.readTextFile("hdfs://server02:8020/data/score.csv")
    // 3. 打印
    csvDataStream.print()
    // 4. 执行任务
    env.execute()
  }

}
