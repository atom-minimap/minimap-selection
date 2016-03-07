<a name="v4.4.0"></a>
# v4.4.0 (2016-03-07)

## :sparkles: Features

- Add plugin origin to created decorations ([645f4130](https://github.com/atom-minimap/minimap-selection/commit/645f41309abf975345cff20e3d4c9e7212e783af))

<a name="v4.3.1"></a>
# v4.3.1 (2015-10-02)

## :bug: Bug Fixes

- Fix potential infinite loop when an editor has no selection ([410e46f0](https://github.com/atom-minimap/minimap-selection/commit/410e46f019909397abf594bcebb3b27c12d6643f), [#6](https://githu

<a name="v4.3.0"></a>
# v4.3.0 (2015-06-29)

## :sparkles: Features

- Implement highlighting lines with cursors ([bbab9ca0](https://github.com/atom-minimap/minimap-selection/commit/bbab9ca036757efbdf018349666022ba7241c1d4), [#5](https://github.com/atom-minimap/minimap-selection/issues/5))

## :racehorse: Performances

- Doesn't recreate decorations when selection ranges changes ([b9df94f8](https://github.com/atom-minimap/minimap-selection/commit/b9df94f8716de1c9133f8c80160d807629941a1d))

<a name="v4.2.0"></a>
# v4.2.0 (2015-03-01)

## :sparkles: Features

- Implement minimap service consumer for plugin registration ([84a2d37f](https://github.com/atom-minimap/minimap-selection/commit/84a2d37fef5edeabf88867bc90004fc348d6afa3))

<a name="v4.1.0"></a>
# v4.1.0 (2015-02-20)

## :truck: Repository Migration

- Migrate package repository to atom-minimap organization ([f7b01e01](https://github.com/atom-minimap/minimap-selection/commit/f7b01e0119d2fcc8b1da8951d4c7142eb31379f6))

<a name="v4.0.1"></a>
# v4.0.1 (2015-02-10)

## :arrow_up: Dependencies Update

- Update atom-space-pen-views to version 2.x ([d4aabbf4](https://github.com/atom-minimap/minimap-selection/commit/d4aabbf4819d3e3c4d7f98987a5dc9c13b229931))
- Update event-kit to version 1.x ([5087e006](https://github.com/atom-minimap/minimap-selection/commit/5087e006d6641b4481638a2c390f58c7cfac7efc))

<a name="v4.0.0"></a>
# v4.0.0 (2015-02-10)

## :sparkles: Features

- Add TravisCI setup ([3b9b6799](https://github.com/atom-minimap/minimap-selection/commit/3b9b679993c7541e05f06e642a197a8b68a9d493))

## :bug: Bug Fixes

- Fix errors raised when destroying the minimap ([c65692b5](https://github.com/atom-minimap/minimap-selection/commit/c65692b52e48b44585dd15575dbefd0e1420a6fb), [#4](https://github.com/atom-minimap/minimap-selection/issues/4))

<a name="v3.1.1"></a>
# v3.1.1 (2015-01-08)

## :bug: Bug Fixes

- Remove call to deprecated method ([3601f069](https://github.com/atom-minimap/minimap-selection/commit/3601f069b22a4cc80a2ea6aa1fe42e32c0fbf4bc))

<a name="v3.1.0"></a>
# v3.1.0 (2015-01-05)

## :sparkles: Features

- Implement support for both minimap v3 and v4 API ([096c17e3](https://github.com/atom-minimap/minimap-selection/commit/096c17e3a7af1f9cc7d3ab6746b64519ea7ae93e))

<a name="3.0.1"></a>
# 3.0.1 (2014-12-05)

## :bug: Bug Fixes

- Fix use of deprecated minimap API ([f477b519](https://github.com/atom-minimap/minimap-selection/commit/f477b519870afbeea18624024ef9cf91c448dc96))
- Fix removal of inexistant decoration ([58559b81](https://github.com/atom-minimap/minimap-selection/commit/58559b818c05b4c0998f8223f3a251feea5c7393))
- Fix error raised when expanding the number of cursors ([c3d7b679](https://github.com/atom-minimap/minimap-selection/commit/c3d7b6797132dbf0219eadff2f5382b11e9dfceb))
- Fix broken plugin with latest minimap changes ([413f3a30](https://github.com/atom-minimap/minimap-selection/commit/413f3a306ac732be4998c400432ae0cea45e8bbe))

<a name="v3.0.0"></a>
# v3.0.0 (2014-09-19)

## :sparkles: Features

- Add version test for minimap v3 ([dfd89398](https://github.com/atom-minimap/minimap-selection/commit/dfd893984152e389b87ec154da01e64af2b55e37))
- Add a minimap class to the decoration scope ([050b072b](https://github.com/atom-minimap/minimap-selection/commit/050b072bb8e16925341fa97425dc10e288d25e8e))
  <br>It’ll allow to have a specific style for the minimap selection
- Implement support for the new minimap decoration API ([58d084b8](https://github.com/atom-minimap/minimap-selection/commit/58d084b8704780fcf63652ef41f13fcb29981ae0))

<a name="0.1.0"></a>
# 0.1.0 (2014-08-17)

## :sparkles: Features

- Display buffer's selections on the minimap
