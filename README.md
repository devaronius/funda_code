# funda

Funda code task.

to run task include the following

```yaml
"--dart-define","KEY=xxxx"
```

to set api key as a dart global in the application
fro vs code configrations:

```yaml
"configurations": [
        {
            "name": "funda",
            "request": "launch",
            "type": "dart",
            "toolArgs": [
                "--dart-define",
                "KEY=xxxx"
            ]
        },
]
```

