defmodule FFT do
  @moduledoc """
  Documentation for `FFT`.

  There's some significant opportunity for cleanup here, but for now I just wanted to get something that worked together in a few hours. Getting around
  not having nice mutable array stuff was a bit of a pain, as you can see with `generate_y_arr`. Would love to come up with a better way to do that.

  TODO: Figure out how to make this do non-powers of two? This will probably require digging a
  """
  use Complex.Kernel

  @i Complex.new(0, 1)

  @doc """
  Pass this function an array of polynomial coefficients to FFT. It will print the FFT'd and re-inverted versions of them.
  Make sure the array is a power of 2 in length! Bad things will happen otherwise!
  """
  def eval_fft(coeff_array) do
    IO.inspect(fft(coeff_array), label: "FFT")
    IO.inspect(fft(coeff_array) |> ifft(true), label: "INVERTED")
  end

  def principal_nth_root_of_unity(n) do
    Math.e() ** (2 * Math.pi() * @i / n)
  end

  def principal_nth_root_of_unity_ifft(n) do
    Math.e() ** (-2 * Math.pi() * @i / n)
  end

  def nth_root_of_unity_to_j(n, j), do: principal_nth_root_of_unity(n) ** j

  def nth_root_of_unity_to_j_ifft(n, j), do: principal_nth_root_of_unity_ifft(n) ** j

  def generate_y_arr(y, y_even, y_odd, j, n, invert \\ false) do
    # Have to do this instead of match because of `Complex.Kernel`
    if j == n / 2 do
      y
    else
      w = if invert, do: nth_root_of_unity_to_j_ifft(n, j), else: nth_root_of_unity_to_j(n, j)

      y
      |> List.replace_at(
        j,
        Enum.at(y_even, j) + w * Enum.at(y_odd, j)
      )
      |> List.replace_at(
        trunc(j + n / 2),
        Enum.at(y_even, j) - w * Enum.at(y_odd, j)
      )
      |> generate_y_arr(y_even, y_odd, j + 1, n, invert)
    end
  end

  # Base case, return list when list is only one. This is a constant.
  def fft([_coeff] = p), do: p

  def fft(p) do
    n = length(p)

    # Split into even and odd functions, taking every other coefficient
    # p0, p2, p4...
    p_even = Enum.take_every(p, 2)
    # p1, p3, p5...
    p_odd = p |> Enum.drop(1) |> Enum.take_every(2)

    y_even = fft(p_even)
    y_odd = fft(p_odd)

    generate_y_arr(List.duplicate(nil, n), y_even, y_odd, 0, n)
  end

  def ifft([_coeff] = p), do: p

  def ifft(p, final \\ false) do
    n = length(p)

    # Split into even and odd functions, taking every other coefficient
    # p0, p2, p4...
    p_even = Enum.take_every(p, 2)
    # p1, p3, p5...
    p_odd = p |> Enum.drop(1) |> Enum.take_every(2)

    y_even = ifft(p_even)
    y_odd = ifft(p_odd)

    out = generate_y_arr(List.duplicate(nil, n), y_even, y_odd, 0, n, true)

    if final, do: Enum.map(out, fn num -> num / n end), else: out
  end
end
