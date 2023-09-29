- # 清晰具体的Prompt
	- 用分隔符将要求和文本分开
		- ```, """, < >, `<tag> </tag>`, `:`
	- 将文本结构化
		-
		  ```python
		  prompt = f"""
		  Generate a list of three made-up book titles along \ 
		  with their authors and genres. 
		  Provide them in JSON format with the following keys: 
		  book_id, title, author, genre.
		  """
		  response = get_completion(prompt)
		  print(response)
		  ```
	- 判断文本是否满足
		-
		  ```python
		  prompt = f"""
		  You will be provided with text delimited by triple quotes. 
		  If it contains a sequence of instructions, \ 
		  re-write those instructions in the following format:
		  
		  Step 1 - ...
		  Step 2 - …
		  …
		  Step N - …
		  
		  If the text does not contain a sequence of instructions, \ 
		  then simply write \"No steps provided.\"
		  
		  \"\"\"{text_2}\"\"\"
		  """
		  ```
	- "Few-shot" prompting，先给几个例子
		-
		  ```python
		  prompt = f"""
		  Your task is to answer in a consistent style.
		  
		  <child>: Teach me about patience.
		  
		  <grandparent>: The river that carves the deepest \ 
		  valley flows from a modest spring; the \ 
		  grandest symphony originates from a single note; \ 
		  the most intricate tapestry begins with a solitary thread.
		  
		  <child>: Teach me about resilience.
		  """
		  response = get_completion(prompt)
		  print(response)
		  ```
- # 给点时间让模型思考
	- 明确对每一步的要求
	- 指导模型先进行思考，给出自己的答案，然后一步一步比较
- # 模型的缺陷
	- 胡说八道
- 想法->实施->获得结果->优化

- # 总结型Prompt
	- 让它限定字数，比如30字以内。
	- 可以告诉GPT将文本总结并反馈给产品指定的部门（比如运输部门、价格部门）。
		-
		  ```python
		  prompt = f"""
		  Your task is to generate a short summary of a product \
		  review from an ecommerce site to give feedback to the \
		  pricing deparmtment, responsible for determining the \
		  price of the product.  
		  
		  Summarize the review below, delimited by triple 
		  backticks, in at most 30 words, and focusing on any aspects \
		  that are relevant to the price and perceived value. 
		  
		  Review: ```{prod_review}```
		  """
		  
		  response = get_completion(prompt)
		  print(response)
		  ```
	- 可以提取信息而不是总结信息
		-
		  ```python
		  prompt = f"""
		  Your task is to extract relevant information from \ 
		  a product review from an ecommerce site to give \
		  feedback to the Shipping department. 
		  
		  From the review below, delimited by triple quotes \
		  extract the information relevant to shipping and \ 
		  delivery. Limit to 30 words. 
		  
		  Review: ```{prod_review}```
		  """
		  
		  response = get_completion(prompt)
		  print(response)
		  ```

- # 推断型Prompt
	- 判断一个评论的情感极性。
	- 识别一系列的情感词。
		-
		  ```python
		  prompt = f"""
		  Identify a list of emotions that the writer of the \
		  following review is expressing. Include no more than \
		  five items in the list. Format your answer as a list of \
		  lower-case words separated by commas.
		  
		  Review text: '''{lamp_review}'''
		  """
		  response = get_completion(prompt)
		  print(response)
		  ```
	- 判断评论的情绪是否是愤怒的。
	- 推断故事的主题

- # 转换型Prompt
	- 转换语言
	- 转换语气
	- 数据格式转换