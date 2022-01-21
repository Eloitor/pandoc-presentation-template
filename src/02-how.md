# How?

- Clone this repository
  
  ```bash
  git clone https://github.com/Eloitor/pandoc-presentation-template.git
  ```

- Install `pandoc` and `entr`
  
  ```bash
  sudo apt-get install pandoc entr
  ```

- run

  ```bash
  make live_preview
  ```

- Edit and save any file in `src/`. The corresponding file in `preview/` will be updated.

- When you are done, run

  ```bash
  make
  ```

  This will generate some files in `output/`.
  - The ones with "presentation" in the name are the slides, showing each step of the presentation.
  - The ones with "print" in the name are the printable versions of the slides.
  - The ones with "notes" in the name contain speaker notes.
  - The ones with "2x3" are arranged in 2x3 grid.
