-- Staff-only dashboard: apply when the login version of the dashboard is live
-- and every staff member has an account + a row in public.staff.
--
-- After this, only signed-in staff can READ, EDIT or DELETE dashboard data
-- (so only staff can view or export it).
-- Device traffic keeps working, checked against the API logs on 18 Nov 2026:
--   * gateways POST /harvest_data with no "Prefer: return=representation" -> needs INSERT only (kept for anon)
--   * gateways upsert /gateway_status (on_conflict=gateway_id)          -> needs INSERT+UPDATE+SELECT (kept for anon;
--     this table only holds heartbeats, no harvest data)
--
-- Add staff:    insert into public.staff(email,name) values ('someone@example.com','Name');
-- Remove staff: delete from public.staff where email = 'someone@example.com';

-- harvest_data: anyone (devices) may insert; only staff may read. Nobody may update/delete via the API.
drop policy if exists "Allow public read access" on public.harvest_data;
create policy "hd read staff" on public.harvest_data for select to authenticated using ((select public.is_staff()));

-- palm_trees
drop policy if exists "pt read" on public.palm_trees;
drop policy if exists "pt insert" on public.palm_trees;
drop policy if exists "pt update" on public.palm_trees;
create policy "pt read staff"   on public.palm_trees for select to authenticated using ((select public.is_staff()));
create policy "pt insert staff" on public.palm_trees for insert to authenticated with check ((select public.is_staff()));
create policy "pt update staff" on public.palm_trees for update to authenticated using ((select public.is_staff())) with check ((select public.is_staff()));
create policy "pt delete staff" on public.palm_trees for delete to authenticated using ((select public.is_staff()));

-- heatmap_blocks
drop policy if exists "hb read" on public.heatmap_blocks;
drop policy if exists "hb insert" on public.heatmap_blocks;
drop policy if exists "hb update" on public.heatmap_blocks;
drop policy if exists "hb delete" on public.heatmap_blocks;
create policy "hb read staff"   on public.heatmap_blocks for select to authenticated using ((select public.is_staff()));
create policy "hb insert staff" on public.heatmap_blocks for insert to authenticated with check ((select public.is_staff()));
create policy "hb update staff" on public.heatmap_blocks for update to authenticated using ((select public.is_staff())) with check ((select public.is_staff()));
create policy "hb delete staff" on public.heatmap_blocks for delete to authenticated using ((select public.is_staff()));

-- signal_blocks
drop policy if exists "sb read" on public.signal_blocks;
drop policy if exists "sb insert" on public.signal_blocks;
drop policy if exists "sb update" on public.signal_blocks;
drop policy if exists "sb delete" on public.signal_blocks;
create policy "sb read staff"   on public.signal_blocks for select to authenticated using ((select public.is_staff()));
create policy "sb insert staff" on public.signal_blocks for insert to authenticated with check ((select public.is_staff()));
create policy "sb update staff" on public.signal_blocks for update to authenticated using ((select public.is_staff())) with check ((select public.is_staff()));
create policy "sb delete staff" on public.signal_blocks for delete to authenticated using ((select public.is_staff()));

-- test_batches
drop policy if exists "tb read" on public.test_batches;
drop policy if exists "tb insert" on public.test_batches;
drop policy if exists "tb update" on public.test_batches;
drop policy if exists "tb delete" on public.test_batches;
create policy "tb read staff"   on public.test_batches for select to authenticated using ((select public.is_staff()));
create policy "tb insert staff" on public.test_batches for insert to authenticated with check ((select public.is_staff()));
create policy "tb update staff" on public.test_batches for update to authenticated using ((select public.is_staff())) with check ((select public.is_staff()));
create policy "tb delete staff" on public.test_batches for delete to authenticated using ((select public.is_staff()));

-- devices
drop policy if exists "dev read" on public.devices;
drop policy if exists "dev write" on public.devices;
create policy "dev read staff"   on public.devices for select to authenticated using ((select public.is_staff()));
create policy "dev insert staff" on public.devices for insert to authenticated with check ((select public.is_staff()));
create policy "dev update staff" on public.devices for update to authenticated using ((select public.is_staff())) with check ((select public.is_staff()));
create policy "dev delete staff" on public.devices for delete to authenticated using ((select public.is_staff()));

-- gateway_status: unchanged (gateway heartbeat upsert needs anon select/insert/update).
