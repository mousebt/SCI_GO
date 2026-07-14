# 论文版本控制

## 建议节奏

- 完成研究简报后提交一次。
- 每个章节形成可审阅版本后提交一次。
- 每轮内部评审、投稿和返修各提交一次并打标签。
- 纯格式修复可以合并；结论、边界或数字的变化必须单独提交。

## 提交示例

```text
paper/my-study: lock core claim and scope
paper/my-study: add results section for Figure 2
paper/my-study: revise causal wording after statistics review
knowledge: promote validated paragraph-mapping technique
```

## 里程碑标签

```text
paper-my-study-v0.1-outline
paper-my-study-v0.5-internal-review
paper-my-study-v1.0-submitted
paper-my-study-v1.1-revision-1
paper-my-study-v2.0-accepted
```

Git 记录“文件变了什么”，`change-log.md` 记录“为什么变、由谁确认、会影响什么”。两者不能互相替代。
