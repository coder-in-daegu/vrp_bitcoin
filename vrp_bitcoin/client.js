async function loadScaleform(scaleform) {
    let scaleformHandle = RequestScaleformMovie(scaleform);
  
    return new Promise(resolve => {
      const interval = setInterval(() => {
        if (HasScaleformMovieLoaded(scaleformHandle)) {
          clearInterval(interval);
          resolve(scaleformHandle);
        } else {
          scaleformHandle = RequestScaleformMovie(scaleform);
        }
      }, 0);
    });
  }
  
  const url = 'http://니네서버아이피/btclive';
  const scale = 0.435;
  const sfName = 'hypnonema_texture_renderer01';
  
  const width = 1280;
  const height = 720;
  
  let sfHandle = null;
  let txdHasBeenSet = false;
  let duiObj = null;
  
  setTick(() => {
    if (sfHandle !== null && !txdHasBeenSet) {
      PushScaleformMovieFunction(sfHandle, 'SET_TEXTURE');
  
      PushScaleformMovieMethodParameterString('meows'); // txd
      PushScaleformMovieMethodParameterString('woof'); // txn
  
      PushScaleformMovieFunctionParameterInt(0); // x
      PushScaleformMovieFunctionParameterInt(0); // y
      PushScaleformMovieFunctionParameterInt(width);
      PushScaleformMovieFunctionParameterInt(height);
  
      PopScaleformMovieFunctionVoid();
  
      txdHasBeenSet = true;
    }
  
    if (sfHandle !== null && HasScaleformMovieLoaded(sfHandle)) {
      DrawScaleformMovie_3dNonAdditive(
        sfHandle,
        249.47308349609,-765.39166259766,30.439079284668+6.15,
        0, 20, 0,
        2, 2, 2,
        scale * 1, scale * (9/16), 1,
        2,
      );
    }
  });
  
  on('onClientResourceStart', async (resName) => {
    if (resName === GetCurrentResourceName()) {
      sfHandle = await loadScaleform(sfName);
  
      runtimeTxd = 'meows';
  
      const txd = CreateRuntimeTxd('meows');
      const duiObj = CreateDui(url, width, height);
      const dui = GetDuiHandle(duiObj);
      const tx = CreateRuntimeTextureFromDuiHandle(txd, 'woof', dui);
    }
  })
  
  on('onResourceStop', (resName) => {
    if (resName === GetCurrentResourceName()) {
      DestroyDui(duiObj);
      SetScaleformMovieAsNoLongerNeeded(sfName)
    }
  })