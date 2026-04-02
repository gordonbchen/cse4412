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


#align(center)[
  #text(22pt, weight: "bold")[Quantum HW 2]
  #v(0.3em)
  #text(14pt)[Gordon Chen]
]
#v(1em)

= Shor's Algorithm
Simulate part of Shor’s algorithm by hand (using also a basic calculator when needed).

Let $N = 21 = 3 times 7$ which we wish to factor. Solve the following problems:

#set enum(numbering: "a)")
+ Write out all elements $x in {0, · · · , N−1}$ such that $gcd(x, N) = 1$.
  For each of these, compute manually (e.g., brute-force-search using
  a calculator) the order of each element. Namely, for every $x$ with
  $gcd(x, N) = 1$, find the smallest non-zero $r$ such that $x^r = 1 mod N$.
  What fraction of these are even?

  #let g(body) = table.cell(fill: green.lighten(60%))[#body]
  #solution[
    #table(
      columns: 13,
      [*x*], [1], [2], [4], [5], [8], [10], [11], [13], [16], [17], [19], [20],
      [*r*], [1], g[6], [3], g[6], g[2], g[6], g[6], g[2],  [3], g[6], g[6], g[2],
    )

    $9/12 = 3/4$ have even order.
  ]


+ For each of those that have even order, compute $x^(r/2)+1$ and $x^(r/2)−1$ (not modulo).
  What fraction of these are not an integer multiple of N?
  For those that aren’t, show how taking the $gcd(x^(r/2) + 1, N)$ or $gcd(x^(r/2) − 1, N)$
  lead to a non trivial factor of 21 (either 3 or 7).

  #let o(body) = table.cell(fill: orange.lighten(30%))[#body]
  #solution[
    #table(
      columns: 10,
      [*x*], [2], [5], [8], [10], [11], [13], [17], [19], [20],
      [*r*], [6], [6], [2], [6],  [6],  [2],  [6],  [6],  [2],
      [*$x^(r/2)$*], [8], [125], [8], [1000], [1331], [13], [4913], [6859], [20],
      [*$x^(r/2) + 1$*], [9], g[126], [9], [1001], [1332], [14], g[4914], [6860], g[21],
      [*$x^(r/2) - 1$*], [7], [124], [7], [999], [1330], [12], [4912], [6858], [19],
      [*$gcd(x^(r/2) + 1, 21)$*], o[3], [], o[3], o[7], o[3], o[7], [], o[7], [],
      [*$gcd(x^(r/2) - 1, 21)$*], o[7], [], o[7], o[3], o[7], o[3], [], o[3], [],
    )

    $6/9 = 2/3$ are not a multiple of $N$.
  ]

+ Pick $x = 10$ "randomly". It’s order should be 6. Note it has an even order and
  neither $x^(r/2) + 1$ or $x^(r/2) − 1$ is a multiple of $N$.
  (Technically, this is “cheating” since we would normally pick randomly, find $r$ through Shor’s algorithm,
  and repeat if this test fails - but since you’re simulating the algorithm, there’s no point in picking
  “wrong” at the start). Next, pick the smallest $Q$ such that $Q >= N^2$ and your chosen $r$ divides $Q$.

  #solution[
    Let $Q = 444$. $Q/r = 442 / 6 = 74$ and $Q >= N^2 = 21^2 = 441$.
  ]

#let ket(x) = $|#x chevron.r$
#let bra(x) = $angle.l #x |$
#let braket(a, b) = $angle.l #a | #b chevron.r$
+ From your choices above, compute the following:

  $ 1/sqrt(Q) sum_(a=0)^(Q-1) ket(a) ket(x^a mod 21) $

  (Don’t write out all terms of course since your Q is probably larger than 441,
  just enough to see the pattern)

  #solution[
    $1/sqrt(Q) sum_(a=0)^(Q-1) ket(a) ket(x^a mod 21)$

    $= 1/sqrt(444) (ket(0)ket(1)+ket(1)ket(10)+ket(2)ket(16)+ket(3)ket(13)+ket(4)(4)+ket(5)ket(19)+ket(6)ket(1)+...)$
  ]


+ Next, simulate a measurement of the second register. In particular, choose a "random" $x^a$
  for the state to collapse to. Write out the resulting post-measurement state (again, don’t write out all
  terms, just enough to see a pattern and write the rest using, for example, ellipses...)

  #solution[
    The second register collapses to $ket(16)$. Then the post-measurement state becomes:

    $= 1/sqrt(444/6) (ket(2)ket(16)+ket(8)ket(16)+ket(14)ket(16)+...)$

    $= 1/sqrt(74) (ket(2)ket(16)+ket(8)ket(16)+ket(14)ket(16)+...)$
  ]
