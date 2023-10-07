# 论文异常检测

## 开发进度

- [x] 学习Prompt工程
<progress id="file" max="100" value="100">100%</progress>

- [ ] 梳理系统模型框架
<progress id="file2" max="100" value="70">70%</progress>

- [ ] 相关性验证
<progress id="file3" max="100" value="0">0%</progress>

## Oct 7th, 2023

Member: Junital

Past: 已全部学完Prompt Engineering，下来的骨头就比较难啃了。涉及到比较系统的代码和调试。

[箱形图](./draw/variable_box_plot.ipynb)报错了，明天继续研究一下。

## Oct 6th, 2023

Member: Junital

Past: 把Prompt工程中的聊天机器人一节学完，更新[笔记](./learn/learn_prompt_engineering/Pompt%20Engineering.md)

Plan: 下一步想先把箱形图画了，直观看一下每个变量的相关性，然后考虑要不要线性判别分析。

Difficulty: 注意图片的风格要与上次的那个评论长度统计的图一致。然后需要考虑一下最后的整个模型框架了，感觉异常检测+LLM光是分析评论也很单薄（这里提出一个小小的想法：做一个数据库与LLM结合的系统，让LLM有查数据库的功能，从而可以根据一些历史信息做出一些更加准确的判断）

## Oct 5th, 2023

Member: Junital

Past: 暂停一天，先忙课内任务。

## Oct 4th, 2023

Member: Junital

Past: 重新规划了一下[滚轮总结（Rolling Summary）算法](/algorithm/rolling_summary.ipynb)，伪代码如下：

```python
Roll = None
PC = None
for sentence in sentences:
    if(|Roll| + |sentence| > MAX_TOKEN or sentence = last_sentence):
        if(|Roll| + |sentence| <= MAX_TOKEN):
            Roll += sentence
        PC = summary_with_PC(PC, Question)
        Roll = sentence
    else:
        Roll += sentence
```

为了保守起见，我先选一个长度大于16000的评论做一下测试，看一下最后总结完之后长度是多少。

<div align='center'>

<img src=./fig/Snipaste_2023-10-04_21-10-43.jpg width=80%/>

</div>

可以看出来还是整个答案还是很长的。

Plan: 现在要么就是进行二重滚轮总结，要么就在Prompt中说要压缩回答的长度。

Difficulty: 还是要注意这个Prompt的使用次数，尽量不能太多，不然成本会很高。

## Oct 3rd, 2023

Member: Junital

Past：继续学习Prompt工程，更新[笔记](/learn/learn_prompt_engineering/Pompt%20Engineering.md)。

Plan: 酝酿一下更新“滚轮总结”算法，平衡问答次数和信息压缩。另外，自己想到可以用盒子图来描述所有变量的相关性。

Difficulty: 最后的整体模型尽可能要用到多方面信息，最好可以梳理出一套框架，供工业评论风险检测使用。

## Oct 2nd, 2023

Member: Junital

Past: 尝试使用下面的算法对评论进行处理：

```python
previous_context = None

for sentence in sentences:
    previous_context = summary_with_previous_context(previous_context, sentence)
```

<div align='center'>

<img src=./fig/Snipaste_2023-10-02_18-39-57.jpg width=80%/>

</div>

我认为把这个归纳方法叫做“滚轮总结”较为合适，之后由于不够完善，需要再改改。

Plan：目前还需要提升的地方

- 有些评论是没有有效信息的，那些得通过LLM帮助过滤一下。

- 需要把所有和LLM相关的函数进行包装，方便之后的可持续开发。

Difficulty: 目前认为这个成本太高了，问了LLM太多次问题了，可以再加入一些思路进去。

## Oct 1st, 2023

Member: Junital

Past: 我尝试对所有评论进行长度统计，结果出乎我的预料。如下图所示，虽然大多数的评论都处在比较安全的Token长度内，但是还是有少部分评论会出现超过长度的现象。长度大于5000的评论有1386条，长度大于16000的评论有125条，因为评论本身就具有无限递增的情况，因此我还是觉得需要想办法对评论进行一步步压缩。

<div align='center'>

<img src=./fig/length_of_reviews.png width=80%/>

</div>

Plan: 探索一下怎么既保证信息上下文不会丢失，并且整个评论的token可以被压缩（因为事实上有用的信息量不是很多）

Difficulty: 如果成功了，最好用一个名字来概括这个方法。

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