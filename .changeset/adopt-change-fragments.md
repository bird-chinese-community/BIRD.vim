---
bump: patch
category: changed
---

- 🧾 **引入可审计的变更片段** / **Adopt auditable change fragments**

  新增零依赖的变更片段工作流，可在 PR 中记录语义版本级别和双语发布说明，
  并在发布时按分类汇总到 CHANGELOG。

  Added a dependency-free change-fragment workflow that records semantic version
  bumps and bilingual release notes in pull requests, then groups them into the
  changelog during release preparation.
