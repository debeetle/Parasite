import sys

def remove_hyphens(text):
    return text.replace('- ', '')

def fix_line_breaks(input_text):
    buffer = ""
    lines = input_text.splitlines()
    
    for line in lines:
        for word in line:
            line = remove_hyphens(line)  # 删除连接符
    
    # 处理剩余的缓冲内容
    if buffer:
        return buffer.strip()
    return ""

if __name__ == "__main__":
    # 从标准输入读取文本
    input_text = sys.stdin.read()
    fixed_text = fix_line_breaks(input_text)
    
    # 输出结果供 wl-copy 使用
    print(fixed_text)
