const config = {
  appId: 'com.sighdev.fotomu.app',
  appName: 'FOTOMU',
  // Root HTML file is one folder above backend, so webDir must point to the app root
  webDir: '../',
  bundledWebRuntime: false,
  server: {
    androidScheme: 'https'
  },
  plugins: {
    SplashScreen: {
      launchShowDuration: 2000,
      launchAutoHide: true,
      backgroundColor: '#2b0a0a',
      androidSplashResourceName: 'splash',
      iosSplashResourceName: 'Default'
    }
  }
};

export default config;