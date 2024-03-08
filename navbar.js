document.addEventListener('DOMContentLoaded', (event) => {
    const navbarHTML = `
    <nav>
        <ul>
            <li><a href="/index">Homepage</a></li>
            <li><a href="/students-page">Students</a></li>
            <li><a href="/alumni">Alumni</a></li>
            <li><a href="/schools">Schools</a></li>
            <li><a href="/consultations">Consultations</a></li>
            <li><a href="/programs">Programs</a></li>
            <li><a href="/school-programs">Schools Programs</a></li>
            <li><a href="/alumni">Alumni</a></li>
        </ul>
    </nav>
    `;
    document.body.insertAdjacentHTML('afterbegin', navbarHTML);
});