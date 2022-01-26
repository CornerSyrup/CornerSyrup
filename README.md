# CornerSyrup

Repo for personal development and storing config files and etc.

## Usage

```ps
# Install scoop and related apps
curl https://raw.githubusercontent.com/CornerSyrup/CornerSyrup/main/bin/install-scoop.ps1 | powershell
```

## Self-Intro

```go
package CornerSyrup

import "sync"

var bucketList sync.WaitGroup

func init() {
	go keepAlive()
}

func main() {
	nowLearning(&bucketList)
	go findThings2Learn(&bucketList)
	go watchVTuber("Flare Shiranui")

	bucketList.Wait()
}

func findThings2Learn(wg *sync.WaitGroup) {
	for {
		if topic, isInteresting := explore(); isInteresting {
			wg.Add(1)
			go learnNewThing(topic, wg)
		}
	}
}

func nowLearning(wg *sync.WaitGroup) {
	wg.Add(2)
	go learnNewThing("kafka", wg)
	go learnNewThing("esperanto", wg)
}
```
