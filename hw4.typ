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
#let bra(x) = $angle.l #x |$
#let braket(a, b) = $angle.l #a | #b chevron.r$

#align(center)[
  #text(22pt, weight: "bold")[Quantum HW 3]
  #v(0.3em)
  #text(14pt)[Gordon Chen]
]
#v(1em)

= SARG04 QKD
+ Alice picks random $k in {0, 1}$, random $y in {0, 1}$, sends $H^k ket(y)$.
+ Bob chooses X or Z basis randomly to measure in. Result $b in {ket(0), ket(1), ket(+), ket(-)}$.
+ Alice picks random $z in {0, 1}$, sends $"Perm"(H^(1-k) ket(z), H^k ket(y))$.

#solution[
  #table(
    columns: 5,
    [], [], [B], [], [Perm],
    [],  [], [$Z$], [$X$], [],
    [A], [$k=0: Z$], [$ket(y)$], [$"random" in {ket(+), ket(-)}$], [${H ket(z), ket(y)}$],
    [], [$k=1: X$], [$"random" in {ket(0), ket(1)}$], [$H ket(y)$], [${ket(z), H ket(y)}$],
  )

  If Bob chooses the Z basis:
  - If $k=0$, Alice also chose Z basis. Then the state Bob measures is $ket(y)$, and Bob will see $ket(y)$ in
    the 2 states Alice sends after. So Bob might think that if he chooses $Z$ and sees $b$ in the 2 states,
    then $k=0$.
  - However, if $k=1$, Alice chose the X basis, so Bob will measure and get $ket(0)$ or $ket(1)$ uniformly
    at random. Whether he got $ket(0)$ or $ket(1)$, he has a $1/2$ probability of seeing that same random state
    in the 2 states Alice sent because $ket(z)$ is random.
  - Then, Bob cannot conclude that if he sees $b$ in the 2 states Alice sent then $k=0$ because he still has a
    $1/2$ chance of seeing that his state in Alice's 2 states when $k=1$. So Bob does not know what $k$ is,
    the round is inconclusive.

  Similarly for if Bob chooses the X basis, he cannot conclude what state he is in from seeing $b$ in the
  2 states Alice sent because
  - If $k=0$: $b$ is either $ket(+)$ or $ket(-)$ uniformly at random just like $H ket(z)$, so there is a
    $1/2$ chance that Bob will see hist state.
  - If $k=1$: Bob is guarenteed to see his state in Alice's 2 states.
  - So since Bob can see his state in both cases if $k=0$ or $k=1$, he cannot conclude what $k$ is.

  If Bob does not see his state in the 2 states Alice sent, then
  - He cannot be in $Z_A Z_B$ (where Alice chose $Z$ and Bob chose $Z$) because otherwise his state would be
    $ket(y)$ and he is guarenteed to see his state.
  - He cannot be in $X_A X_B$ because otherwise his state is $H ket(y)$ and he is guarenteed to see his state.
  - He knows that he chose $Z$ so he must be in $X_A Z_B$, and randomly got $ket(b) != ket(z)$ so he can't
    see his state in Alice's states. Then he can conclude that $k=1$.
  - He knows that he chose $X$ so he must be in $Z_A X_B$, and randomly got $ket(b) != H ket(z)$ so he can't
    see his state in Alice's states. Then he can conclude that $k=0$.

  An adversary who just sees the classical message Alice sent will either see permutations of
  ${H ket(z), ket(y)}$ if $k=0$ or permutations of ${ket(z), H ket(y)}$ if $k=1$.
  Since $z$ and $y$ are chosen at random, without any other quantum information the adversary just sees a
  random classical $ket(+)$ or $ket(-)$ and a random classical $ket(0)$ or $ket(1)$ in both cases. 
  After permuting the 2 states randomly, the adversary also can't just say that if the first state is in the
  $X$ basis then $k=0$. So then in both cases for $k=0$ and $k=1$, the adversary just sees classical messages
  of 2 states, 1 random in the $X$ basis and 1 random in the $Z$ basis, so he cannot tell what $k$ is.
]
