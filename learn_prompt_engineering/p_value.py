import openai

openai.api_key = "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"

def get_completion(prompt, model="gpt-3.5-turbo"):
    messages = [{"role": "user", "content": prompt}]
    response = openai.ChatCompletion.create(
        model=model,
        messages=messages,
        temperature=0, # this is the degree of randomness of the model's output
    )
    return response.choices[0].message["content"]

text = f"""
p值的计算可以追溯到18世纪，当时计算的是人类出生性别比，\ 
并与男女出生概率相同的零假设相比的统计学差异[7]。\ 
约翰·阿布斯诺特于1710年研究了这一问题[8][9][10][11]，\ 
并检查了伦敦从1629年到1710年的82年中每一年的出生记录。\ 
阿布斯诺特观察到每一年在伦敦出生的男婴数都超过了女婴数。\ 
考虑到零假设是男性或女性出生概率相同，这一观察结果出现的概率是1/282，\ 
或约为4,836,000,000,000,000,000分之1；这个计算得到的值，\ 
用现代术语说，就是P值。这个数字小得惊人，\ 
使阿布斯诺特认为这一结果的出现不是由于几率，而是由于神的旨意。\ 
“由此可见，支配一切的是艺术，而不是几率”。用现代术语来说，\ 
他在p=1/282的显著性水平上拒绝了男女出生可能性相同的零假设。
"""
prompt = f"""
请总结下面的文字，用一段话来概括：
{text}
"""
response = get_completion(prompt)
print(response)