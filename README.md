
sliver app bar title is a  widget  that can be used for pinned silver app bar

## Features

- Can target a particular widget in a List
- Animation


<img src="https://raw.githubusercontent.com/itsmeabhi12/sliver_app_bar_title/main/demo.gif" width="400" height="700"/>

## Usage

```dart
class _MyHomePageState extends State<MyHomePage> {
  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: SliverAppBarTitle(
              targetWidgetKey: globalKey,
              duration: const Duration(milliseconds: 100),
              child: const Text("Number 2 is hidden"),
            ),
            expandedHeight: 256,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                color: index.isOdd ? Colors.white : Colors.black12,
                height: 100.0,
                child: Center(
                  child: Text('$index',
                      key: index == 1 ? globalKey : null, textScaleFactor: 5),
                ),
              );
            },
            childCount: 20,
          ))
        ],
      ),
    );
  }
}
```

## Info

Feel Free to request any missing features or report issues [here](https://github.com/itsmeabhi12/sliver_app_bar_title/issues).



## License

```
Copyright (c) 2022 Abhishek Ghimire

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
