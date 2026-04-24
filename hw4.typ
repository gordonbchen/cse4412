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

= Proof of Deletion
+ $r_Z, r_X in {0, 1}^n$.
+ $b in {Z, X}^(2n)$, where half are $Z$.
+ $ket(psi)_i$ is $ket(r_Z)$ if $b_i = Z$, else $H ket(r_X)$ when $b_i = X$.
+ $c = (m xor k xor r_Z, ket(psi))$
+ secret key = $(k, b, r_X)$, throw out $r_Z$
+ proof of deletion: server measures $ket(psi)$ in the $X$ basis, measurement must have $r_X$ where $b=X$.

#solution[
  For someone with the secret key $(k, b, r_X)$ to decrypt the ciphertext $c = (m xor k xor r_Z, ket(psi))$,
  they already have $k$, so they just need to find $r_Z$ (remember this was thrown away)
  from $b$ and $ket(psi)$. They can find $r_Z$ by asking the server to measure all of $ket(psi)$ in the
  $Z$ basis, and the bits of $r_Z$ are in the positions where $b_i = Z$.
  Then they can decrypt with $m = c xor k xor r_Z$.

  So $r_Z$ is stored in $ket(psi)$ in the qubits where $b_i = Z$.

  For a proof of deletion then, the server measures all of $ket(psi)$ in the $X$ basis, which will cause
  the qubits where $r_Z$ is stored to collapse uniform randomly to $ket(+)$ or $ket(-)$. Then $r_Z$ will
  not be able to be recovered.

  A malicious server cannot fake measuring all of $ket(psi)$ and secretly store $ket(psi)$ for future
  attacks either. Since the person with the secret key will check that the measured bits when
  $b_i = X$ match $r_X$, the server has to measure all qubits where $b_i = X$ in the $X$ basis.
  However, the server doesn't know $b$, it is part of the secret key, so to get all $r_X$ correct,
  it really does have to measure all $ket(psi)$ in the X basis.

  If the server tried to not measure $ket(psi)$ and just guess $r_X$, then they would have no better
  than to guess random bits, so the probability of forging a fake proof of deletion is $1/2^n$, which
  is negligible.

  Even if later, the secret key $(k, b, r_X)$ is leaked, no one will be able to decrypt the ciphertext
  $c = (m xor k xor r_Z, ket(psi))$ because no one can find $r_Z$ anymore. The qubits in $ket(psi)$ that
  were storing $r_Z$ were all measured in the $X$ basis, which caused them to collapse to random states
  in the $X$ basis, so $r_Z$ is unrecoverable. Even with $k$ leaked, the xoring with $r_Z$ acts as a
  One Time Pad on $m xor k$, which is completely secure.
]
