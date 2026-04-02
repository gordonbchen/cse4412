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

#let ket(x) = $|#x angle.r$
#let bra(x) = $angle.l #x |$
#let braket(a, b) = $angle.l #a | #b angle.r$


#align(center)[
  #text(22pt, weight: "bold")[Quantum Prog 2]
  #v(0.3em)
  #text(14pt)[Gordon Chen]
]
#v(1em)

= Bernstein-Vazirani
Recall the Bernstein-Vazirani algorithm. Let $f: {0, 1}^n -> {0, 1}$ be a function such that:
$ f(x) = f(x_1 x_2 ... x_n) = x_1 s_1 + x_2 s_2 + ... + x_n s_n (mod 2) $
for some secret bit string $s in {0, 1}^n$.

The goal of the algorithm is to find $s$ with as few queries as possible.
Classically you need to make n queries to the function; a quantum algorithm can find $s$ with one query.

The algorithm is identical to the Deutsch-Joza algorithm. There are $n + 1$ wires in the algorithm.
First, set the top $n$ wires to all $ket(0)$ and the last wire to the state $ket(1)$.
Next, apply Hadamard gates to all $n + 1$ wires. Next query $f$ by using the oracle gate $U_f$ .
Next, apply Hadamard gates to the top $n$ wires. Finally, measure the top $n$ wires.
The probability the measurement outcome is $s$ is exactly 1.

1. Design a circuit for function $f(x)$ when $n = 2$ and $s = 01$.
  - Briefly describe and justify your design.

    #solution[

    ]


  - Implement the circuit in IBM Quantum Composer. Verify that it provides you
    the desired output. Download the circuit diagram from IBM Quantum Composer
    and include it in your write-up.

    #solution[

    ]


  - What is the state before your Oracle gate (i.e., the state after the first round of
    applying H gates to all the wires)? Do it by hand and verify what you get with
    the output from the IBM Quantum Composer.

    #solution[

    ]


  - What is the state after your Oracle gate? Again, verify what you get by hand
    with the output from the IBM Quantum Composer.

    #solution[

    ]


  - What is the state after the second round of H gates (i.e., right before the final
    measurement)? Again, verify what you get by hand.

    #solution[

    ]


2. Design a circuit for function $f(x)$ when $n = 3$ and $s = 101$. Describe your design and
show the circuit.

#solution[

]

