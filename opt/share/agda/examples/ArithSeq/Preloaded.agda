{-# OPTIONS --safe #-}
module Preloaded where

open import Data.Nat

arith-sum : ℕ → ℕ
arith-sum zero = zero
arith-sum (suc n) = suc n + arith-sum n


arith-formula : ℕ → ℕ
arith-formula n = ⌊ n * (n + 1) /2⌋