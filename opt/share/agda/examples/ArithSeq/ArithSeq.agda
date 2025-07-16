{-# OPTIONS --safe #-}
module ArithSeq where

open import Data.Nat
open import Data.Nat.Properties
open import Relation.Binary.PropositionalEquality

open import Preloaded

2n+m : (n m : ℕ) → ⌊ (n + n) + m /2⌋ ≡ n + ⌊ m /2⌋
2n+m zero m = refl
2n+m (suc n) m rewrite +-comm n (suc n) | 2n+m n m = refl

suc[n*n+1] : (n : ℕ) → suc n * (suc n + 1) ≡ ((suc n) + (suc n)) + n * (n + 1)
suc[n*n+1] n rewrite *-comm n (suc (n + 1)) | *-comm (n + 1) n | +-comm n 1 | +-comm n (suc n) |
    +-assoc n n (n * suc n) = refl

af : (n : ℕ) → arith-formula (suc n) ≡ (suc n) + arith-formula n
af n rewrite suc[n*n+1] n | 2n+m (suc n) (n * (n + 1)) = refl

arith-eq : (n : ℕ) -> arith-formula n ≡ arith-sum n
arith-eq zero = refl
arith-eq (suc n) rewrite af n | arith-eq n = refl