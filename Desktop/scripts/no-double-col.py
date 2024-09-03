#!/usr/bin/env python3
import sys
import re

def process_text(text):
    # 分割文本为行
    lines = text.splitlines()
    processed_lines = []
    current_line = ""
    
    for i, line in enumerate(lines):
        # 检查下一行是否存在且有缩进（新段落）
        if i < len(lines) - 1 and lines[i+1].startswith(' '):
            # 如果当前行不为空，添加到processed_lines
            if current_line:
                processed_lines.append(current_line)
            # 添加当前行（可能是段落结尾）
            processed_lines.append(line)
            current_line = ""
        else:
            # 连接当前行，删除行尾连字符
            current_line += line.rstrip('-')
            if not line.endswith('-'):
                current_line += ' '
    
    # 添加最后一行
    if current_line:
        processed_lines.append(current_line)
    
    # 连接所有处理过的行
    text = '\n'.join(processed_lines)
    
    # 删除单词中的连字符
    text = re.sub(r'(\w+)-\s*(\w+)', r'\1\2', text)
    
    # 删除多余的空格
    text = re.sub(r'\s+', ' ', text)
    
    return text.strip()

if __name__ == "__main__":
    # 从标准输入读取文本
    input_text = sys.stdin.read()
    
    # 处理文本
    processed_text = process_text(input_text)
    
    # 输出处理后的文本到标准输出
    print(processed_text, end='')
