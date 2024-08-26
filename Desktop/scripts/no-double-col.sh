#!/bin/bash

# 函数:移除单词中的连接符
remove_hyphens() {
    sed 's/-//g' <<< "$1"
}

# 主函数:处理换行符和句子断行
process_text() {
    local indent_pattern='^[ \t]'  # 用于检测行首缩进的模式
    local prev_line=""              # 存储上一行的内容
    local curr_line=""              # 存储当前行的内容

    while read -r line; do
        curr_line=$(remove_hyphens "$line")  # 移除当前行中的连接符

        if [[ "$curr_line" =~ $indent_pattern ]]; then
            # 当前行有缩进,说明是新的句子开始
            echo "$prev_line"
            prev_line="$curr_line"
        else
            # 当前行没有缩进,将其连接到上一行
            prev_line="$prev_line$curr_line"
        fi
    done

    echo "$prev_line"  # 输出最后一行
}
