#!/bin/sh
#撤销操作
rails destroy scaffold MainPage

#创建控制器StaticPages和Action home、help
rails g controller StaticPages home help
