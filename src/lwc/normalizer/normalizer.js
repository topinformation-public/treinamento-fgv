function removeEmojis (text) {
    let pattern = /(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])/g;
    return text.replace(pattern, '');
}

function keepOnlyRestrictAlpha (text) {
    return removeEmojis(text).replace (/[^A-Za-z]+/g, '');
}

function keepOnlyAlphaNumeric (text) {
    return removeEmojis(text).replace (/[^A-Za-zÀ-ú0-9\s]|[÷×±¬؆؇϶؇؈⁒⁺⁻⁼₊₋₌⅀℘⅋]|[\u2190-\u22FF]|[\u27C0-\u27FF]|[\u2900-\u29FF]|[\u2A00-\u2AFF]+/g, '');
}

//deprecated
function keepOnlyAphaNumeric (text) {
    return keepOnlyAlphaNumeric(text);
}

function keepOnlyNumeric (text) {
    return text.replace(/[^0-9]/g,"");
}

// deprecated use keepOnlyAphaNumeric
function keepOnlyText (text) {
    return keepOnlyAphaNumeric (text);
}

//TO BE REMOVED
function keepOnlyApha (text) {
    return keepOnlyAlpha(text);
}

function keepOnlyAlpha (text) {
    return text.replace (/[^A-Za-zÀ-ú\s]|[÷×±¬؆؇϶؇؈⁒⁺⁻⁼₊₋₌⅀℘⅋]|[\u2190-\u22FF]|[\u27C0-\u27FF]|[\u2900-\u29FF]|[\u2A00-\u2AFF]+/g, '');
}

function keepOnlyEmailText(text) {
    return text.replace(/[^A-Za-z0-9!#$%&’*+/=?^`{|}~._@]/g, '');
}

function notEmpty (value) {
    return value && value !== '';
}


export { removeEmojis, keepOnlyRestrictAlpha, keepOnlyAlphaNumeric, keepOnlyAphaNumeric, keepOnlyNumeric, keepOnlyText, keepOnlyApha, keepOnlyAlpha, keepOnlyEmailText, notEmpty };