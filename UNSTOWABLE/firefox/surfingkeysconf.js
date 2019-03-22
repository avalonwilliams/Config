// Copyright 2018 Aidan Williams 
//
// Permission is hereby granted, free of charge,
// to any person obtaining a copy of this software
// and associated documentation files (the "Software"), 
// to deal in the Software without restriction, 
// including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit
// persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission
// notice shall be included in all copies or 
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS",
// WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
// AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
// OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
// DEALINGS IN THE SOFTWARE.

// Note that this is served over a localhosted website on an apache server,
// because firefox plugins can't access local files

// Map Shift+h to navigate backwards in history
map("H", "S");

// Map Shift+l to navigate forwards in history
map("L", "D");

// Map Shift+k to go to next tab
map("K", "R");

// Map Shift+j to go to previous tab
map("J", "E");


// Startpage search engine
addSearchAlias(
    'p',
    'startpage',
    'https://www.startpage.com/do/dsearch?query=',
    'https://www.startpage.com/cgi-bin/csuggest?format=json&limit=10&query=',
    function(response) { return JSON.parse(response.text)[1]; }
);

mapkey('op', '#8Open Search with alias p', function() {
    Front.openOmnibar({type: "SearchEngine", extra: "p"});
});

// Set duckduckgo as default search engine
settings.defaultSearchEngine = 'd';
