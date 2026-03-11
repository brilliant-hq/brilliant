---
assumes: blueprint/text
---
# Blueprint Styled Ranges

## Syntax

`spans[...]` continuation line under a text element for mixed formatting:

```
t("Get started for free today",Inter,18) f[(#0F172A)]
  spans[("Get started",b),("free",b,#3B82F6)]
```

**Mods:** `b` bold · `i` italic · `u` underline · `w(N)` weight · `s(N)` size · `f(family)` font · `#hex` color

**Duplicate words:** Add 0-based occurrence index — `("the",0,b),("the",1,i)`

## Key Patterns

### Accent Word
```
t("Build something amazing",Inter,48,b) f[(#1C1917)]
  spans[("amazing",b,#3B82F6)]
```

### Price Format
```
t("$49/month",Inter,14) f[(#0F172A)]
  spans[("$49",s(36),b,#3B82F6),("/month",#64748B)]
```

### Stat with Unit
```
t("2,847 users",Inter,32,b) f[(#0F172A)]
  spans[("users",w(600),s(16),#64748B)]
```

### Mixed Typeface
```
t("The art of modern design",Lora,44,b) f[(#1C1917)]
  spans[("modern design",f(Inter))]
```

### Feature Keyword
```
t("Unlimited projects for your team",Inter,15) f[(#334155)]
  spans[("Unlimited",w(600),#0F172A)]
```

Always style: hero headlines (accent word), prices (large amount + small unit), stats (bold number + lighter label). Usually: feature titles. Rarely: body. Never: captions.
