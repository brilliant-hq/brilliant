---
assumes: blueprint/text
---
# Blueprint Styled Ranges

## Syntax

`spans[...]` continuation line under a text element for mixed formatting:

```
t("Get started for free today",Inter,18) f[(#0F172A)] #cta_text
  spans[("Get started",b),("free",b,#E11D48)]
```

**Mods:** `b` bold · `i` italic · `u` underline · `w(N)` weight · `s(N)` size · `f(family)` font · `#hex` color · `o(N)` opacity (0–1)

**Duplicate words:** Add 0-based occurrence index — `("the",0,b),("the",1,i)`

## Key Patterns

```
t("Build something amazing",Inter,48,b) f[(#1C1917)]
  spans[("amazing",s(48),f(Bungee Shade),#E57C00)]
t("$49/month",Inter,14) f[(#0F172A)]
  spans[("$49",s(36),b,#10B981),("/month",#64748B)]
t("2,847 users",Inter,32,b) f[(#0F172A)]
  spans[("users",w(600),s(16),#64748B)]
t("The art of modern design",Lora,44,b) f[(#1C1917)]
  spans[("art",f(Nothing You Could Do),#7A00FF),("modern design",f(Inter),#242424)]
t("Run npm install to get started",Inter,15) f[(#334155)]
  spans[("npm install",f(Fira Code),#D946EF)]
t("Free forever \u00B7 No credit card required",Inter,14) f[(#64748B)]
  spans[("Free forever",b,#0F172A),("No credit card required",b,#0F172A)]
```

Always style: hero headlines (accent word/font), prices (large amount + small unit), stats (bold number + lighter label). Usually: feature titles, inline code. Rarely: body. Never: captions.
