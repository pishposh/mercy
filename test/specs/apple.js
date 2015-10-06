describe("visitor to www.apple.com", function() {
    afterEach(screenshotIfFailed);
    afterEach(skipRestIfFailed);

    she("loads the the page", async () => {
        await browser.url("http://www.apple.com");
    });

    she("clicks the hamburger", async () => {
        await browser.click(".ac-gn-menuicon-bread-top");
    });

    she("clicks the search box", async () => {
        await browser.waitForVisible(".ac-gn-search-placeholder", 2000);
        await browser.click(".ac-gn-search-placeholder");
    });

    she("types the word “imac”", async () => {
        await browser.keys("imac");
        await browser.keys("Return");
    });

    she("sees the title imac - Apple", async () => {
        var title = await browser.getTitle();
        assert.equal(title, "imac - Apple");
    });
});
