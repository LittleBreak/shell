
#!bin/sh

# 修改文件md5,否则无法入库
# 在每个zip里的xml文件后追加空格
# 需指定一个路径，即文件路径
# 脚本需要在home路径下创建一个临时目录


path=/root/shell/2.2
work_dir=~/$(date +%Y%m%d%H%M%S)_batch
# 创建工作目录
mkdir $work_dir
mkdir -p $work_dir/unzipfile
mkdir -p $work_dir/zipfile
unzip_path=$work_dir/unzipfile

echo $work_dir
echo $work_dir/unzipfile
# 解压所有压缩包
for file in `ls ${path}`
do
  basename=${file:0:36}
  unzip ${path}/$file -d $work_dir/unzipfile/$basename  
done

# 修改xml文件并重新压缩
for file in `ls ${unzip_path}`; do
  cd ${work_dir}/unzipfile/$file/
  echo " " >> ${work_dir}/unzipfile/$file/$file.xml
  zip -r $file.zip *
  mv ${work_dir}/unzipfile/$file/$file.zip ${work_dir}/zipfile
done

output=batch_output_$(date +%H%M%S)
mkdir ~/$output
cp -r $work_dir/zipfile ~/$output
rm -rf $work_dir