---
title: Introduction
description: Data transformation toolkit
layout: gem-single
type: gem
name: dry-transformer
sections:
  - transformation-objects
  - built-in-transformations
  - using-standalone-functions
---

dry-transformer is a library that allows you to compose procs into a functional pipeline using left-to-right function composition. The approach came from Functional Programming, where simple functions are composed into more complex functions in order to transform some data. It works like `|>` in Elixir or `>>` in F#. dry-transformer provides a mechanism to define and compose transformations, along with a number of built-in transformations. It's currently used as the data mapping backend in [rom-rb](https://rom-rb.org).
