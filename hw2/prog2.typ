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

#let t = h(0.1em)
#let ket(x) = $lr(|#t #x #t chevron.r)$
#let ket2(x,y) = $lr(|#t #x,#t #y #t chevron.r)$
#let bra(x) = $lr(chevron.l #t #x #t|)$
#let bra2(x,y) = $lr(chevron.l #t #x,#t #y #t|)$
#let braket(x,y) = $lr(chevron.l #t #x #t|#t #y #t chevron.r)$
#let braket2(x1,y1,x2,y2) = $lr(chevron.l #t #x1,#t #y1 #t|#t #x2,#t #y2 #t chevron.r)$

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
      We follow Deutsch-Joza:
      + $3$ input wires, initial state $ket(001)$
      + $H^(times.o 3)$
      + $U_f$ :

        $
        U_f ket2(x, y) &= ket2(x, f(x) xor y) = ket2(x, (x dot s) xor y) = ket2(x, (0 x_0 xor 1 x_1) xor y) \
        &= ket2(x, x_1 xor y)
        $

        So $U_f$ just needs a CNOT from $x_1$ to $y$.

      + $H^(times.o 2)$
    ]


  - Implement the circuit in IBM Quantum Composer. Verify that it provides you
    the desired output. Download the circuit diagram from IBM Quantum Composer
    and include it in your write-up.

    #solution[
      #image("img/bv.png")

      After throwing away the last qubit, the quantum state will be $ket(01)$. Measuring will give us
      $s = 01$, which is the correct output.
    ]


  - What is the state before your Oracle gate (i.e., the state after the first round of
    applying H gates to all the wires)? Do it by hand and verify what you get with
    the output from the IBM Quantum Composer.

    #solution[
      $
      H^(times.o 3) ket(001) &= ket(++-) \
      &= 1/(sqrt(2)^3) (ket(0) + ket(1)) (ket(0) + ket(1)) (ket(0) - ket(1)) \
      &= 1/(sqrt(2)^3) (ket(00) + ket(01) + ket(10) + ket(11)) (ket(0) - ket(1)) \
      &= 1/(sqrt(2)^3) (ket(000)+ket(010)+ket(100)+ket(110)-ket(001)-ket(011)-ket(101)-ket(111)) \
      $

      #image("img/bv_inith.png")

      The state after the inital H gates is an equal superposition of all states where the states with a $ket(1)$
      in the last register have a negative phase.
    ]


  - What is the state after your Oracle gate? Again, verify what you get by hand
    with the output from the IBM Quantum Composer.

    #solution[
      $
      U_f 1/(sqrt(2)^3) (ket(000)+ket(010)+ket(100)+ket(110)-ket(001)-ket(011)-ket(101)-ket(111))\
      = 1/(sqrt(2)^3) (ket(000)+ket(011)+ket(100)+ket(111)-ket(001)-ket(010)-ket(101)-ket(110)) \
      $

      #image("img/bv_uf.png")

      The states with negative phases are $ket(001), ket(010), ket(101), ket(110)$.
    ]


  - What is the state after the second round of H gates (i.e., right before the final
    measurement)? Again, verify what you get by hand.

    #solution[
      $
      &H^(times.o 2) 1/(sqrt(2)^3) (ket(000)+ket(011)+ket(100)+ket(111)-ket(001)-ket(010)-ket(101)-ket(110)) \
      &=H^(times.o 2) 1/(sqrt(2)^3) (ket(00)-ket(01)+ket(10)-ket(11))ket(-) \
      &=H^(times.o 2) 1/(sqrt(2)^2) (ket(00)-ket(01)+ket(10)-ket(11)) wide "discarding last qubit"\
      &=H^(times.o 2) ket(+-)\
      &=ket(01)\
      $

      #image("img/bv_final.png")

      The state is $ket(01)$ after discarding the last qubit.
    ]


2. Design a circuit for function $f(x)$ when $n = 3$ and $s = 101$. Describe your design and
show the circuit.

#solution[
  + 4 wires, initial state $ket(0001)$
  + $H^(times.o 4)$
  + $U_f$

    $U_f ket2(x, y) = ket2(x, (x dot 101) xor y) = ket2(x, x_0 xor x_2 xor y)$

    So we CNOT $x_0$ to $y$ and $x_2$ to $y$ to make $U_f$.

  + $H^(times.o 3)$

  #image("img/bv3.png")

  After throwing away the last qubit the state is $ket(101)$, which will be $s=101$ when measured.
]
