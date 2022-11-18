# Elixir FFT

I wanted to understand Fast Fourier Transforms (FFT) a bit better and write it in Elixir, so here we are. This is obviously a bit of a toy version, but still pretty fun to put together. This is not a particularly spectacular implementation, but it is one.

Huge shoutout to [Reducible](https://www.youtube.com/watch?v=h7apO7q16V0), [Veritasium](https://www.youtube.com/watch?v=nmgFG7PUHfo), and [3B1B](https://www.youtube.com/watch?v=spUNpyF58BY) for the great videos on the topic. Definitely recommended viewing if you're interested and want to learn more.

This implementation is derived heavily from Reducible's pseudocode, as well as the very helpful competitive programming oriented writeup with a C++ implementation [here](https://cp-algorithms.com/algebra/fft.html).

## Why FFT?
FFT is a highly influential algorithm used in signal processing, compression, and mathematics. It is a very useful algorithm with lots of applications in our modern world, and for that reason I felt (just a bit) ashamed that I didn't understand it all that well. I still don't, but hey, at least it's a bit less not that well now. This really is a genius algorithm that should be appreciated by all.

