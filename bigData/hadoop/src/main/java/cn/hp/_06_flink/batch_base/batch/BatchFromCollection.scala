package cn.hp._06_flink.batch_base.batch

import org.apache.flink.api.scala._

object BatchFromCollection {

  def main(args: Array[String]): Unit = {
    // 新建SparkConf,SparkContext,StreamingContext -- spark
    // 1. 创建批处理运行环境
    //StreamExecutionEnvironment.getExecutionEnvironment
    val env: ExecutionEnvironment = ExecutionEnvironment.getExecutionEnvironment

    // 2. 加载本地数据
    val localEle: DataSet[String] = env.fromElements("hadoop", "spark", "flink")
    localEle.print()

    // 加载元组
    val tupleDataSet: DataSet[(String, Int)] = env.fromElements(("spark", 1), ("flink", 2))
    tupleDataSet.print()

    // 加载本地集合
    val listDataSet: DataSet[String] = env.fromCollection(List("flink", "spark", "hadoop"))
    listDataSet.print()

    // 加载序列
    val seqDataSet: DataSet[Long] = env.generateSequence(1, 9)
    seqDataSet.print()
  }
}
