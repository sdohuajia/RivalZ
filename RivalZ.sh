#!/bin/bash

# 安装依赖和 RivalZ 函数
function install_all() {
    # 更新包列表和升级系统
    echo "更新包列表和升级系统..."
    sudo apt update && sudo apt upgrade -y

    # 安装 Git、curl、screen 和 npm
    for pkg in git curl screen npm; do
        echo "安装 $pkg..."
        sudo apt install -y $pkg
        if command -v $pkg &>/dev/null; then
            echo "$pkg 安装成功!"
        else
            echo "$pkg 安装失败，请检查错误信息。"
            exit 1
        fi
    done

    # 安装 Rivalz
    echo "安装 Rivalz..."
    if npm list -g rivalz-node-cli &>/dev/null; then
        echo "Rivalz 已经安装。"
    else
        npm i -g rivalz-node-cli
        if npm list -g rivalz-node-cli &>/dev/null; then
            echo "Rivalz 安装成功!"
        else
            echo "Rivalz 安装失败，请检查错误信息。"
            exit 1
        fi
    fi

    echo "依赖和 RivalZ 节点安装完成。"
}

# 打开新屏幕
function start_rivalz() {
    echo "打开新屏幕..."
    screen -S rivalz -d -m
    echo "新屏幕已打开。"
    read -p "按任意键返回主菜单..."
}

# 删除 Rivalz
function remove_rivalz() {
    echo "删除 Rivalz..."
    if [ -f /usr/bin/rivalz ]; then
        echo "找到 Rivalz，正在删除..."
        sudo rm /usr/bin/rivalz
        echo "Rivalz 已删除。"
    else
        echo "Rivalz 不存在，无法删除。"
    fi

    # 删除 /root/.rivalz 文件夹
    if [ -d /root/.rivalz ]; then
        echo "找到 /root/.rivalz 文件夹，正在删除..."
        sudo rm -rf /root/.rivalz
        echo "/root/.rivalz 文件夹已删除。"
    else
        echo "/root/.rivalz 文件夹不存在。"
    fi

    read -p "按任意键返回主菜单..."
}


# 更新版本
function update_version() {
    echo "更新 Rivalz 版本..."
    rivalz update-version
    rivalz run
    echo "版本更新完成。"
    read -p "按任意键返回主菜单..."
}

# 主菜单函数
function main_menu() {
    while true; do
        clear
        echo "脚本由大赌社区哈哈哈哈编写，推特 @ferdie_jhovie，免费开源，请勿相信收费"
        echo "================================================================"
        echo "节点社区 Telegram 群组: https://t.me/niuwuriji"
        echo "节点社区 Telegram 频道: https://t.me/niuwuriji"
        echo "节点社区 Discord 社群: https://discord.gg/GbMV5EcNWF"
        echo "退出脚本，请按键盘 ctrl + C 退出即可"
        echo "请选择要执行的操作:"
        echo "1) 安装RivalZ节点"
        echo "2) 打开新屏幕"
        echo "3) 删除 Rivalz"
        echo "4) 更新版本"
        echo "0) 退出"
        read -p "输入选项 (0-4): " choice

        case $choice in
            1)
                install_all
                ;;
            2)
                start_rivalz
                ;;
            3)
                remove_rivalz
                ;;
            4)
                update_version
                ;;
            0)
                echo "退出脚本..."
                exit 0
                ;;
            *)
                echo "无效的选项，请重新输入。"
                ;;
        esac

        # 添加提示用户按任意键返回主菜单
        read -p "按任意键返回主菜单..."
    done
}

# 执行主菜单函数
main_menu
