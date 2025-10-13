mason add --global my_brick --path ./path/to/my_brick

//like that

// ./path/to/my_brick

// C:\Users\amazo\Downloads\mason_tdd\mason_tdd

---

also with url not tested

mason add --global mason_tdd --git-url https://github.com/Munawer2022/mason_cli.git --git-path mason_tdd --git-ref removeRepo

---

mason list --global

mason remove -g <BRICK_NAME>

mason upgrade --global

# Generate a new brick with hooks.

mason new <BRICK_NAME> --hooks
mason make <BRICK_NAME> -o lib
mason make <BRICK_NAME> --name hello -o lib

2. **Add bricks to your Mason configuration:**

```bash
# Add all bricks locally
mason add mason_tdd --source path --path ./mason_tdd
mason add mason_tdd_folder --source path --path ./mason_tdd_folder
```
