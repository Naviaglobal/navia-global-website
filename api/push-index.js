export default async function handler(req, res) {
  if (req.method !== 'POST') return res.status(405).end();
  const { content, secret } = req.body;
  if (secret !== 'navia2026push') return res.status(403).json({error: 'forbidden'});
  const token = process.env.GITHUB_TOKEN;
  if (!token) return res.status(500).json({error: 'no github token in env'});
  const getResp = await fetch('https://api.github.com/repos/Naviaglobal/navia-global-website/contents/index.html', {
    headers: { Authorization: `Bearer ${token}`, Accept: 'application/vnd.github.v3+json' }
  });
  const fileData = await getResp.json();
  const updateResp = await fetch('https://api.github.com/repos/Naviaglobal/navia-global-website/contents/index.html', {
    method: 'PUT',
    headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({
      message: 'feat: agregar destinos Alemania y Francia al grid del home',
      content: Buffer.from(content).toString('base64'),
      sha: fileData.sha
    })
  });
  const result = await updateResp.json();
  return res.json({ ok: updateResp.ok, status: updateResp.status, commit: result.commit?.sha || result.message });
}
