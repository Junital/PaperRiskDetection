# 论文异常检测

## 开发进度

- [ ] 学习Prompt工程
<progress id="file" max="100" value="80">80%</progress>

- [ ] 梳理系统模型框架
<progress id="file2" max="100" value="70">70%</progress>

- [ ] 相关性验证
<progress id="file3" max="100" value="0">0%</progress>

## Sep 30th, 2023

Member: Junital

Past: 初步形成了一个思路，先用GPT根据评论回答信息，再让它总结一下自己刚刚的回答，便于之后的信息收集。

<div align='center'>

<img src=./fig/Snipaste_2023-09-30_15-41-34.jpg width=80%/>

</div>

另外，自己构思了一下初步的框架（之后应该需要再加一点元素）。

<div align='center'>

<img src="./fig/Drawing 2023-09-30 15.45.43.excalidraw.png" width=80%/>

</div>

Plan：现在一方面因为学习了高级统计方法，想重新在检验所有变量的相关性上进行科学的研究；另一方面，开始统计目前这些评论的长度，如果评论太长就得继续创新一下处理方法了。

- 关于评论长度那一块，想画一张直方图出来看一下评论的分布，这样可以知道具体的处理方法。

- 想用线性判别的方法来判断所有变量的相关性。

## Sep 29th, 2023

Member: Junital

Past: 学习Prompt Engeering中的Transforming一章，初步对评论进行了GPT问答，目前设定是两个问题。

Plan: 开始尝试更多的评论，争取能把最后的Prompt给呈现出来。

Difficulty: 希望可以有一些创新。

## Sep 24th, 2023

Member: Junital

Past: 事情有点多，没有完成相关任务。

## Sep 23rd, 2023

Member: Junital

Past: 学习Prompt Engeering中的Inferring一章，了解了怎么进行评论的推断、主题归纳。添加原来的异常检测代码到项目中。

Plan: 继续学习[Prompt Engeering](https://www.deeplearning.ai/short-courses/chatgpt-prompt-engineering-for-developers/)，开始尝试处理PubPeer的评论，尝试从多角度进行评价。

Difficulty: 评论之间的“互指”、回复仍然是比较难处理的部分。

## Sep 22nd, 2023

Member: Junital

Past: 学习Prompt Engeering中的Summary一章，了解了怎么进行评论的总结、凝练和提取，提交了相关笔记。

Plan: 继续学习[Prompt Engeering](https://www.deeplearning.ai/short-courses/chatgpt-prompt-engineering-for-developers/)，构思框架。

Difficulty: 整个评论不能一次性丢入GPT，但是拆开来又会失去评论的连贯性，可能存在评论互相指引的情况。

## Sep 21st, 2023

Member: Junital

Past: 开启项目，确定主要任务

Plan: 先学习[Prompt Engeering](https://www.deeplearning.ai/short-courses/chatgpt-prompt-engineering-for-developers/), 顺便把整体的框架进行设计。

Difficulty: 目前最大的问题是如何巧妙运用LLM来解决评论Token量太大的问题。