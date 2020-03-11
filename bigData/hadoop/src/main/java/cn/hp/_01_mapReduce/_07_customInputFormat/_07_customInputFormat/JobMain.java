package cn.hp._01_mapReduce._07_customInputFormat._07_customInputFormat;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.BytesWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.SequenceFileOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;
import static cn.hp._01_mapReduce.HdfsUtil.getLocalInputSourcePath;

public class JobMain extends Configured implements Tool {
    @Override
    public int run(String[] args) throws Exception {
        //1:获取job对象
        Job job = Job.getInstance(super.getConf(), "sequence_file_job");

        //2:设置job任务
        //第一步:设置输入类和输入的路径
        job.setInputFormatClass(MyInputFormat.class);//TODO 设置一个文件夹读取里面所有的文件 文件合并
//        MyInputFormat.addInputPath(job, new Path("file:///D:\\11期全部东西\\hadoop_sy\\day08\\资料\\自定义InputFormat\\input"));
        MyInputFormat.addInputPath(job, getLocalInputSourcePath(JobMain.class));
        MyInputFormat.addInputPath(job, getLocalInputSourcePath(JobMain.class,"source2.txt"));


        //第二步:设置Mapper类和数据类型
        job.setMapperClass(SequenceFileMapper.class);
        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(BytesWritable.class);

        //第七步: 不需要设置Reducer类,但是必须设置数据类型
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(BytesWritable.class);

        //第八步:设置输出类和输出的路径
        job.setOutputFormatClass(SequenceFileOutputFormat.class);
        Path path = new Path("file:///C:\\out\\flowpartiton_out" + Math.random());
        System.err.println(path.toString());
        FileOutputFormat.setOutputPath(job, path);


        //3:等待job任务执行结束
        boolean bl = job.waitForCompletion(true);
        return bl ? 0 : 1;
    }

    public static void main(String[] args) throws Exception {
        Configuration configuration = new Configuration();

        int run = ToolRunner.run(configuration, new JobMain(), args);

        System.exit(run);
    }
}
