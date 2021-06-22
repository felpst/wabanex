defmodule Wabanex.IMC do # module is a collection of functions
  def calculate(%{"filename" => filename}) do # Here I am creating a simple function that gets a file, and then sends it to a function.
    filename
    |> File.read() # Here I am using what is called the pipe operator, that here is getting the value from filename, and assign it to File.read(), and then getting the value coming out of it and assiging it to handle_file(). The pipe operator is a combination of | and >
    |> handle_file()
  end

  defp handle_file({:ok, content}) do # Here I am defining a private function, therefore it only exists inside of this file. For this function I am checking via pattern matching if the result is a tuple composed by an ok and something (content), if it is then it will return the content, otherwise it will try to execute the next function that handles an error.
    data =
      content
      |> String.split("\n")
      |> Enum.map(fn line -> parse_line(line) end) # Enum is used for all the structures that I can "walk through" (percorrer). Inside of it I have created a anonymous function by using "fn element -> what_the_function_does end"
      |> Enum.into(%{})

    {:ok, data} # Here I am returning a 'ok' and a result.
  end
  defp handle_file({:error, _reason}) do # since I am not using reason here, I have added a _ to it
    {:error, "Error while opening the file"}
  end

  defp parse_line(line) do
    line
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1) # IO.inspect() here will print what the String.split() will return. &String.to_float/1 is the same thing as usaing a anonymous function (fn element -> String.to_float(element) end) but shorter. The 1 from the first parameter will get the first first position element
    |> List.update_at(2, &String.to_float/1) # A dictionary/hash table here is created as %{"Key" => 0.00}, I am using a => here because the key is a string. The /1 is how many arguments the function asks for (in this case it is 1).
    |> calculate_imc()
  end

  defp calculate_imc([name, height, weight]), do: {name,weight / (height * height)} # I am applying here the pattern matching to the function's arguments. The , do: allows me to create a "one line function".
end
