# Antigravity Multi-Agent Loop & Frontier Refinement (Windows Edition)

Bộ đóng gói kiến trúc **Agent Loop + Multi-Agent Orchestration** với cơ chế **Frontier Critic-in-the-Loop** chuyên trị các bài toán phức tạp trên môi trường Windows (PowerShell & Antigravity CLI).

---

## 🌟 Điểm nổi bật trong kiến trúc mới

1. **Chu trình phối hợp khép kín (Critic-in-the-Loop):**
   - Không chỉ tạo kế hoạch rồi để code worker làm tự do.
   - Khi `@code-worker` hoàn thành bản code sơ bộ kèm kết quả test, **Frontier Model (`@architect-reviewer`)** sẽ kiểm tra, soi edge cases, concurrency, security.
   - Vòng lặp phản biện và tự sửa lỗi được kích hoạt tự động cho tới khi sản phẩm đạt chuẩn (`STATUS: APPROVED`), chặn lặp tối đa 3 vòng để tránh hao token.
2. **Xuất báo cáo tổng kết (`SESSION_LOG.md`):**
   - Sau khi hoàn thành, hệ thống xuất báo cáo tóm tắt các thay đổi, bug đã fix qua từng vòng lặp, và đưa ra 2-3 hướng tối ưu tiếp theo để người dùng lựa chọn (Performance, Hardening, Coverage...).
3. **Cơ chế Dynamic Model Tiers:**
   - **Tự động nhận diện (Auto-detect):** Dùng cơ chế bí danh thông minh (`inherit` / `pro` / `flash`), tự động trỏ tới model cao nhất có trong gói tài khoản hiện hành.
   - **Tùy chọn đa dạng:** Hỗ trợ từ gói tiết kiệm (`starter`) đến gói tối đa công lực (`frontier_elite` gán cố định Argon 4, Opus 5.5).

---

## 🚀 Hướng dẫn cài đặt nhanh trên Windows

Mở **PowerShell** (Run as Administrator hoặc User thường đều được) tại thư mục `antigravity-agent-loop-windows`:

### 1. Cài đặt chế độ Tự động (Khuyên dùng)
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\install.ps1
```
*Hệ thống sẽ tự nhận diện gói tài khoản của bạn và kích hoạt model tối ưu nhất.*

### 2. Cài đặt theo gói Plan mong muốn:
- **Gói Tiết kiệm / Miễn phí (Fast & Low token):**
  ```powershell
  .\install.ps1 -Tier starter
  ```
- **Gói Pro (Cân bằng cao giữa tốc độ và suy luận):**
  ```powershell
  .\install.ps1 -Tier pro
  ```
- **Gói Frontier Max / Siêu kiến trúc (Argon 4 & Opus 5.5):**
  ```powershell
  .\install.ps1 -Tier frontier_elite
  ```

---

## 📂 Quy trình vận hành tự động

Mỗi khi bạn gõ lệnh `/goal <Mục tiêu kỹ thuật>` trong khung chat:

```
[Mục tiêu khó /goal]
        │
        ▼
1. @code-worker (Context codebase & logs)          ──► SPEC_DIGEST.md
        │
        ▼
2. @architect-reviewer (Soi rủi ro kiến trúc)      ──► SPEC_FEEDBACK.md
        │
        ▼
3. @architect-lead (Chốt giải pháp tối ưu)        ──► ARCH_PLAN.md
        │
        ▼
4. @code-worker (Phân rã task chi tiết)           ──► TASKS.md
        │
        ▼
┌────────────────── VÒNG LẶP ACTOR-CRITIC (Tối đa 3 vòng) ──────────────────┐
│                                                                           │
│   5. @code-worker (Viết code & Chạy Test)                                 │
│            ▲                              │                               │
│            │                              ▼                               │
│     (Chỉ thị sửa)          Frontier Reviewer (@architect-reviewer)        │
│            │                 ├─ Còn lỗi ──► Yêu cầu sửa & Lặp lại         │
│            └─────────────────┤                                            │
│                              └─ Đạt chuẩn (STATUS: APPROVED)              │
│                                           │                               │
└───────────────────────────────────────────┼───────────────────────────────┘
                                            ▼
6. Bàn giao & Báo cáo                      ──► SESSION_LOG.md
(Tóm tắt công việc đã làm, danh sách test pass, gợi ý 2-3 hướng tối ưu tiếp theo)
```

---

## ⚙️ Tùy chỉnh Model Tiers theo ý muốn

Bạn có thể chỉnh sửa trực tiếp file cấu hình tại:
`C:\Users\<Tên_User>\.gemini\config\agent-loop\model_tiers.json`

```json
{
  "active_tier": "auto",
  "max_refinement_loops": 3,
  "tiers": {
    "auto": {
      "worker_model": "inherit",
      "reviewer_model": "pro",
      "lead_model": "pro"
    },
    "frontier_elite": {
      "worker_model": "pro",
      "reviewer_model": "Argon 4",
      "lead_model": "Opus 5.5"
    }
  }
}
```

---

## 🗑️ Cách Gỡ bỏ cài đặt (Uninstall)

Khi không còn nhu cầu sử dụng:
```powershell
.\uninstall.ps1
```
Script sẽ tự động dọn sạch các subagent, rules và cấu hình liên quan mà không làm ảnh hưởng đến các cài đặt khác của Antigravity CLI.
