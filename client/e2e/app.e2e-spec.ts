import { ObkWebPage } from './app.po';

describe('obkweb App', function() {
  let page: ObkWebPage;

  beforeEach(() => {
    page = new ObkWebPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
