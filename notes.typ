#let solution(body) = block(
  width: 100%,
  fill: rgb("#f4f8ff"),
  stroke: rgb("#c7d7f2"),
  inset: 12pt,
  above: 10pt,
  below: 10pt,
  [
    #strong[Solution]

    #body
  ],
)

#let todo(body) = box(
  fill: rgb("#ff6666"),
  stroke: rgb("#cc4444"),
  inset: (x: 6pt, y: 4pt),
  [*TODO:* #body],
)

#let ket(x) = $|#x chevron.r$
#let bra(x) = $chevron.l#x|$
#let braket(a, b) = $chevron.l #a|#b chevron.r$

#align(center)[
  #text(22pt, weight: "bold")[Quantum Notes]
  #v(0.3em)
  #text(14pt)[Gordon Chen]
]
#v(1em)


= 2.1
- $ket(v) = vec(alpha, beta) in CC^n$

- addition: $ket(psi) + ket(phi.alt) = vec(a,b) + vec(c,d) = vec(a+x, b+y)$

- scalar multiplication: $z ket(psi) = z vec(a, b) = vec(z a, z b)$

- distributive property: $z (ket(u) + ket(v)) = z ket(u) + z ket(v)$

- vector space $V$ over $CC$
  - closed under addition and scalar multiplication:
    $ket(u), ket(v) in V => alpha ket(u) + beta ket(v) in V$
  - ex: $V = {(alpha, 0): a in CC)}$ is a vector space (a vector subspace of $CC^2$)

- spanning set $S subset V$ st $forall ket(v) in V: ket(v) = sum_(ket(s) in S) alpha_s ket(s)$
  - every vector in $V$ can be written as a linear combination of vectors in $S$. $S$ spans $V$.

- basis $B subset V$ is a minimal spanning set: $forall ket(b_i) in B$,
  cannot find $a_j$ st $ket(b_i) = sum_(i != j) a_j ket(b_j)$
  - no vector in $B$ can be written as a linear combination of others in $B$

- dimension of $V$ is the number of basis vectors of $V$

- vector space $V$ is an inner product space if $exists f: V times V -> CC$
  - linear in second argument: $f(ket(v), sum_i alpha_i ket(w_i)) = sum_i alpha_i f(ket(v), ket(w_i))$
  - $f(ket(v), ket(w)) = f(ket(w), ket(v))^*$
  - $f(ket(v), ket(v)) >= 0$, and $f(ket(v), ket(v)) = 0 <==> ket(v) = 0$

- $ket(v) = (alpha_1, ..., alpha_n)^T, ket(w) = (beta_1, ..., beta_n)^T in CC^n$ then
  $f(ket(v), ket(w)) = sum_i alpha_i^* beta_i$

- $bra(v) times ket(w) = ket(v)^T ket(w) = braket(v, w)$
