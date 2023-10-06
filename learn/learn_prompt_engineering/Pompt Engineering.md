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

- # 补充型Prompt
	- 自动生成回复邮件
		-
		  ```python
		  prompt = f"""
		  You are a customer service AI assistant.
		  Your task is to send an email reply to a valued customer.
		  Given the customer email delimited by ```, \
		  Generate a reply to thank the customer for their review.
		  If the sentiment is positive or neutral, thank them for \
		  their review.
		  If the sentiment is negative, apologize and suggest that \
		  they can reach out to customer service. 
		  Make sure to use specific details from the review.
		  Write in a concise and professional tone.
		  Sign the email as `AI customer agent`.
		  Customer review: ```{review}```
		  Review sentiment: {sentiment}
		  """
		  ```
	- Temperature: 值越高，就越有概率接收一些低概率的单词，从而增加了灵活性，会更有创造力。
- # 聊天机器人
	-
	  ```python
	  def get_completion_from_messages(messages, model="gpt-3.5-turbo", temperature=0):
	      response = openai.ChatCompletion.create(
	          model=model,
	          messages=messages,
	          temperature=temperature, # this is the degree of randomness of the model's output
	      )
	  #     print(str(response.choices[0].message))
	      return response.choices[0].message["content"]
	  ```
	- 这里的Message分为System、User、Assitant三部分。System是指示指令，给定相关的背景、User是用户说的话，Assitant是机器人说过的话。
	-
	  ```python
	  messages =  [  
	  {'role':'system', 'content':'You are an assistant that speaks like Shakespeare.'},    
	  {'role':'user', 'content':'tell me a joke'},   
	  {'role':'assistant', 'content':'Why did the chicken cross the road'},   
	  {'role':'user', 'content':'I don\'t know'}  ]
	  ```
	- 动手做一个聊天机器人
	-
	  ```python
	  import panel as pn  # GUI
	  pn.extension()
	  
	  panels = [] # collect display 
	  
	  context = [ {'role':'system', 'content':"""
	  You are OrderBot, an automated service to collect orders for a pizza restaurant. \
	  You first greet the customer, then collects the order, \
	  and then asks if it's a pickup or delivery. \
	  You wait to collect the entire order, then summarize it and check for a final \
	  time if the customer wants to add anything else. \
	  If it's a delivery, you ask for an address. \
	  Finally you collect the payment.\
	  Make sure to clarify all options, extras and sizes to uniquely \
	  identify the item from the menu.\
	  You respond in a short, very conversational friendly style. \
	  The menu includes \
	  pepperoni pizza  12.95, 10.00, 7.00 \
	  cheese pizza   10.95, 9.25, 6.50 \
	  eggplant pizza   11.95, 9.75, 6.75 \
	  fries 4.50, 3.50 \
	  greek salad 7.25 \
	  Toppings: \
	  extra cheese 2.00, \
	  mushrooms 1.50 \
	  sausage 3.00 \
	  canadian bacon 3.50 \
	  AI sauce 1.50 \
	  peppers 1.00 \
	  Drinks: \
	  coke 3.00, 2.00, 1.00 \
	  sprite 3.00, 2.00, 1.00 \
	  bottled water 5.00 \
	  """} ]  # accumulate messages
	  
	  
	  inp = pn.widgets.TextInput(value="Hi", placeholder='Enter text here…')
	  button_conversation = pn.widgets.Button(name="Chat!")
	  
	  interactive_conversation = pn.bind(collect_messages, button_conversation)
	  
	  dashboard = pn.Column(
	      inp,
	      pn.Row(button_conversation),
	      pn.panel(interactive_conversation, loading_indicator=True, height=300),
	  )
	  
	  dashboard
	  ```
	-
	  ```python
	  messages =  context.copy()
	  messages.append(
	  {'role':'system', 'content':'create a json summary of the previous food order. Itemize the price for each item\
	   The fields should be 1) pizza, include size 2) list of toppings 3) list of drinks, include size   4) list of sides include size  5)total price '},    
	  )
	   #The fields should be 1) pizza, price 2) list of toppings 3) list of drinks, include size include price  4) list of sides include size include price, 5)total price '},    
	  
	  response = get_completion_from_messages(messages, temperature=0)
	  print(response)
	  ```