const API_BASE = 'http://localhost:8080/api';

function getToken() {
    const token = localStorage.getItem('token');
    return (token && token !== 'null') ? token : null;
}

function saveToken(token, email, role) {
    localStorage.setItem('token', token);
    localStorage.setItem('email', email);
    localStorage.setItem('role', role);
}

function logout() {
    localStorage.removeItem('token');
    localStorage.removeItem('email');
    localStorage.removeItem('role');
    window.location.href = '/login.html';
}

function checkAuth() {
    if (!getToken()) {
        window.location.href = '/login.html';
    }
}

async function request(method, path, body = null) {
    const headers = { 'Content-Type': 'application/json' };
    const token = getToken();
    if (token) headers['Authorization'] = `Bearer ${token}`;

    const options = { method, headers };
    if (body) options.body = JSON.stringify(body);

    const res = await fetch(API_BASE + path, options);

    if (res.status === 403 || res.status === 401) {
        logout();
        return;
    }

    if (res.status === 204) return null;
    return res.json();
}

async function downloadExcel(path) {
    const token = getToken();
    const res = await fetch(API_BASE + path, {
        headers: { 'Authorization': `Bearer ${token}` }
    });
    const blob = await res.blob();
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'payments.xlsx';
    a.click();
    URL.revokeObjectURL(url);
}

const get = (path) => request('GET', path);
const post = (path, body) => request('POST', path, body);
const put = (path, body) => request('PUT', path, body);
const del = (path) => request('DELETE', path);
const patch = (path, body) => request('PATCH', path, body);