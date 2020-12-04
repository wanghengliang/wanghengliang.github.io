#!/bin/bash

#version:1.1.0
#author:wanghengliang@outlook.com
#
# create 2017-10-27 wanghengliang v1.0.0 
#   创建-wanghengliang博客创建文章工具
# update 2020-01-13 wanghengliang v1.0.1 
#   调整参数顺序，将创建时间放到最后，方便通过参数创建
#   增加展示版本信息的命名(--version、-V、-v)
# update 2020-12-04 wanghengliang v1.1.0 
#   修改shell脚本的结构，拆分为函数方式实现使得结构更加清晰

version=1.1.0

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


:<<!
显示版本信息
!
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

:<<!
显示帮助文档
!
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

:<<!
参数错误提示信息
!
function tipHelp(){
	echo "参数错误： 通过命令 whladdblog help 查看帮助"
}

:<<!
设置文档文件名
!
function setFileName(){
	if  [ ! -n "$1" ] ;then
		read -p "请输入文件名 > " pFileName
		if  [ ! -n "$pFileName" ] ;then
			echo "没有输入文件名，设置为默认文件名：${defaultFileName}"
			fileName="${defaultFileName}"
		else
			#echo "输入的文件名为：$pFileName"
			fileName="$pFileName"
		fi
	else
		fileName=$1
	fi
}

:<<!
设置文档标题
!
function setTitle(){
	if  [ ! -n "$1" ] ;then
		read -p "请输入文档标题 > " pTitle
		if  [ ! -n "$pTitle" ] ;then
			echo "没有输入文档标题，设置为默认文档标题：${defaultTitle}"
			title="${defaultTitle}"
		else
			#echo "输入的文档标题为：$pTitle"
			title="$pTitle"
		fi
	else
		title=$1
	fi
}

:<<!
设置文档分类
!
function setCategories(){
	if  [ ! -n "$1" ] ;then
		echo "请输入文档分类，现有分类建议如下："
		echo "${existingCategorys}"
		read -p "> " pCategories
		if  [ ! -n "$pCategories" ] ;then
			echo "没有输入文档分类，设置为默认文档分类：${defaultCategories}"
			categories="${defaultCategories}"
		else
			#echo "输入的文档分类为：$pCategories"
			categories="$pCategories"
		fi
	else
		categories=$1
	fi
}

:<<!
设置文档标签
!
function setTags(){
	if  [ ! -n "$1" ] ;then
		echo "请输入文档标签(多个标签用空格分隔)，现有标签建议如下："
		echo "${existingTags}"
		read -p "> " pTags
		if  [ ! -n "$pTags" ] ;then
			echo "没有输入文档标签，设置为默认文档标签：${defaultTags}"
			tags="${defaultTags}"
		else
			#echo "输入的文档标签为：$pTags"
			tags="$pTags"
		fi
	else
		tags=$1
	fi
}

:<<!
设置文档日期
!
function setTime(){
	if  [ ! -n "$1" ] ;then
		read -p "请输入文档时间（格式为%Y-%m-%d，sysdate为当前时间）> " pTime
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
	else
		if [[ ("$1" = "null") || ("$1" = "sysdate") ]] ;then
			ctime="${defaultTime}"
		else
			ctime=$1
		fi
	fi
}

:<<!
设置文档路径
!
function setPostFile(){
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
}

:<<!
创建文档参数(逐个参数设置)
 给出提示信息，进行逐个参数设置，每个参数都给出具体的说明信息
!
function stepCreatePost(){
	# 通过输入进行设置
	# 。。。
	showHelp
	echo ""
	echo ""
	echo ""
	setFileName
	setTitle
	setCategories
	setTags
	setTime

	preview
}

:<<!
创建文档参数(命令行参数)
 通过shell脚本传入参数进行文档参数设置
 调用方法如：
 createPost "$@"
!
function createPost(){
	# 通过shell参数设置
	#for i in "$@"; do
	#	echo $i
	#done
	if  [ -n "$1" ] ;then
		setFileName $1
	fi
	if  [ -n "$2" ] ;then
		setTitle $2
	fi
	if  [ -n "$3" ] ;then
		setCategories $3
	fi
	if  [ -n "$4" ] ;then
		setTags $4
	fi
	if  [ -n "$5" ] ;then
		setTime $5
	fi

	preview
}

:<<!
预览生成结果
 生成文档前先做一个预览，如果生成文档内容不正确可取消生成文档
!

function preview(){
	setPostFile

	echo "将会生成文件${postFile}，内容如下："

	echo "---"
	echo "layout: post"
	echo "title: ${title}"
	echo "date: ${ctime}"
	echo "categories: ${categories}"
	echo "tags: ${tags}"
	echo "---"
	echo "${title}"
	echo ""
	echo ""
	read -p "请确认内容正确后生成文档(yes/no)? " pConfirm
	if [ -n "$pConfirm" ] ;then
		if [[ ("$pConfirm" = "yes") || ("$pConfirm" = "y") ]] ;then
			createPostFile
		else
			echo "已经为您取消生成文档。"
		fi
	else
		echo "已经为您取消生成文档。"
	fi
}

:<<!
创建文档
!
function createPostFile(){
	setPostFile

	echo -e "---" > $postFile
	echo -e "layout: post" >> $postFile
	echo -e "title: ${title}" >> $postFile
	echo -e "date: ${ctime}" >> $postFile
	echo -e "categories: ${categories}" >> $postFile
	echo -e "tags: ${tags}" >> $postFile
	echo -e "---" >> $postFile
	echo -e "${title}" >> $postFile
}


if  [ ! -n "$1" ] ;then
	stepCreatePost
else
	case "$1" in
		"help"|"--help"|"-h")
			showHelp
		;;
		"version"|"--version"|"-v")
			showVersion
		;;
		*)
			createPost "$@"
		;;
	esac
fi
