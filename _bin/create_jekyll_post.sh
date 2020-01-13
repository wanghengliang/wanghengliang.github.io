#!/bin/bash

#version:0.0.2
#author:wanghengliang@outlook.com
#
# create 2017-10-27 wanghengliang v0.0.1 
#   创建-wanghengliang博客创建文章工具
# update 2020-01-13 wanghengliang v0.0.2 
#   调整参数顺序，将创建时间放到最后，方便通过参数创建
#   增加展示版本信息的命名(--version、-V、-v)

version=0.0.2

defaultPostPath="./_posts"
defaultTime=$(date +%Y-%m-%d)
defaultFileName="default"
defaultTitle=""
defaultCategories=""
defaultTags=""

#文件名，支持英文、数字、 下划线_ 、中划线-
fileName="${defaultFileName}"
#文档时间
ctime="${defaultTime}"
#文档标题
title="${defaultTitle}"
#文档分类
categories="${defaultCategories}"
#文档标签
tags="${defaultTags}"

#现有参考分类
existingCategorys="$(cat _site/existingcategorys.txt)"
#现有参考标签
existingTags="$(cat _site/existingtags.txt)"


function showVersion(){
	echo "======================================================================================================================="
	echo "==                                                                                                                   =="
	echo "==                                                                                                                   =="
	echo "==                |      ..|''||    .|'''.|  '||'  '|' '|.   '|'  .|'''.|   ..|''||   '||''''| |''||''|              =="
	echo "==               |||    .|'    ||   ||..  '   ||    |   |'|   |   ||..  '  .|'    ||   ||  .      ||                 =="
	echo "==              |  ||   ||      ||   ''|||.   ||    |   | '|. |    ''|||.  ||      ||  ||''|      ||                 =="
	echo "==             .''''|.  '|.     || .     '||  ||    |   |   |||  .     '|| '|.     ||  ||         ||                 =="
	echo "==            .|.  .||.  ''|...|'  |'....|'    '|..'   .|.   '|  |'....|'   ''|...|'  .||.       .||.                =="
	echo "==                                                                                                                   =="
	echo "==                                                                                                                   =="
	echo "======================================================================================================================="
	echo ":: wanghengliang博客创建文章工具(${version})                                        BUILD-BY: wanghengliang@outlook.com"
}

function showHelp(){
	echo "使用方法："
	echo "命令如下： whladdblog mac_skill MacBook使用小技巧 MacOS MacOS sysdate"
	echo "参数1（M）：文件名，支持英文、数字、 下划线_ 、中划线-"
	echo "参数2（O）：文档标题"
	echo "参数3（O）：文档分类,现有分类建议如下:"
	echo "${existingCategorys}"
	echo "参数4（O）：文档标签,现有标签建议如下:"
	echo "${existingTags}"
	echo "参数5（O）：文档时间，格式为%Y-%m-%d，sysdate为当前时间"
}

# 设置项目编号
if  [ ! -n "$1" ] ;then
	read -p "请输入文件名：" pFileName
	if  [ ! -n "$pFileName" ] ;then
		echo "没有输入文件名，设置为默认文件名：${defaultFileName}"
		fileName="${defaultFileName}"
	else
		#echo "输入的文件名为：$pFileName"
		fileName="$pFileName"
	fi
else
	#帮助文档
	if [[ ("$1" = "--help") || ("$1" = "-H") || ("$1" = "-h") ]] ;then
		showVersion
		echo ""
		echo ""
		showHelp
		exit
	elif [[ ("$1" = "--version") || ("$1" = "-V")  || ("$1" = "-v") ]]; then
		showVersion
		exit
	fi
	#echo "参数设置的文件名为：$1"
	fileName="$1"
fi

# 设置文档标题
if  [ ! -n "$1" ] ;then
	read -p "请输入文档标题：" pTitle
	if  [ ! -n "$pTitle" ] ;then
		echo "没有输入文档标题，设置为默认文档标题：${defaultTitle}"
		title="${defaultTitle}"
	else
		#echo "输入的文档标题为：$pTitle"
		title="$pTitle"
	fi
elif [ ! -n "$2" ] ;then
	echo "没有第2个参数，设置为默认文档标题：${defaultTitle}"
	title="${defaultTitle}"
else
	#echo "参数设置的文档标题为：$2"
	title=$2
fi

# 设置文档分类
if  [ ! -n "$1" ] ;then
	echo "请输入文档分类，现有分类建议如下："
	echo "${existingCategorys}"
	read -p "：" pCategories
	if  [ ! -n "$pCategories" ] ;then
		echo "没有输入文档分类，设置为默认文档分类：${defaultCategories}"
		categories="${defaultCategories}"
	else
		#echo "输入的文档分类为：$pCategories"
		categories="$pCategories"
	fi
elif [ ! -n "$3" ] ;then
	echo "没有第3个参数，设置为默认文档分类：${defaultCategories}"
	categories="${defaultCategories}"
else
	#echo "参数设置的文档分类为：$3"
	categories=$3
fi

# 设置文档标签
if [ ! -n "$1" ] ;then
	echo "请输入文档标签(多个标签用空格分隔)，现有标签建议如下："
	echo "${existingTags}"
	read -p "：" pTags
	if  [ ! -n "$pTags" ] ;then
		echo "没有输入文档标签，设置为默认文档标签：${defaultTags}"
		tags="${defaultTags}"
	else
		#echo "输入的文档标签为：$pTags"
		tags="$pTags"
	fi
elif [ ! -n "$4" ] ;then
	echo "没有第4个参数，设置为默认文档标签：${defaultTags}"
	tags="${defaultTags}"
else
	#echo "参数设置的文档分类为：$4"
	tags=$4
fi

# 设置文档时间
if [ ! -n "$1" ] ;then
	read -p "请输入文档时间（%Y-%m-%d）：" pTime
	if  [ ! -n "$pTime" ] ;then
		echo "没有输入文档时间，设置为默认文档时间：${defaultTime}"
		ctime="${defaultTime}"
	else
		#echo "输入的文档时间为：$pTime"
		if [[ ("$pTime" = "null") || ("$pTime" = "sysdate") ]] ;then
			ctime="${defaultTime}"
		else
			ctime="$pTime"
		fi
	fi
elif [ ! -n "$5" ] ;then
	echo "没有第5个参数，设置为默认文档时间：${defaultTime}"
	ctime="${defaultTime}"
else
	if [[ ("$5" = "null") || ("$5" = "sysdate") ]] ;then
		ctime="${defaultTime}"
	else
		#echo "参数设置的文档标题为：$5"
		ctime=$5
	fi
fi


# 设置文档存放路径
postPath="${defaultPostPath}"
# 如果文档分类不为空则创建分类目录并将其设置为文档存放路径
if [[ ("$categories" != "") ]] ;then
	postPath="${postPath}/${categories}"
fi
# 如果目录不存在则创建目录
if [ ! -d "${postPath}" ]; then
	mkdir ${postPath}
fi

postFile="${postPath}/${ctime}-${fileName}.md"

echo -e "---" > $postFile
echo -e "layout: post" >> $postFile
echo -e "title: ${title}" >> $postFile
echo -e "date: ${ctime}" >> $postFile
echo -e "categories: ${categories}" >> $postFile
echo -e "tags: ${tags}" >> $postFile
echo -e "---" >> $postFile
echo -e "${title}" >> $postFile
